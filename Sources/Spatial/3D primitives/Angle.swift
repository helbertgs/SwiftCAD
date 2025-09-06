import Foundation

/// A geometric angle with a value you access in either radians or degrees.
@frozen public struct Angle : Codable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, Hashable, Sendable {

    // MARK: - Inspecting an angle’s properties

    /// The angle in degrees.
    public let degrees: Double

    /// The angle in radians.
    public let radians: Double

    /// Returns the specified angle normalized between –180° and 180.0°.
    public var normalized: Angle {
        let normalizedDegrees = degrees.truncatingRemainder(dividingBy: 360.0)
        if normalizedDegrees < -180.0 {
            return Angle(degrees: normalizedDegrees + 360.0)
        } else if normalizedDegrees > 180.0 {
            return Angle(degrees: normalizedDegrees - 360.0)
        } else {
            return Angle(degrees: normalizedDegrees)
        }
    }
    
    // MARK: - Creating an angle structure

    /// Creates an angle.
    @inlinable public init() {
        self.degrees = 0.0
        self.radians = 0.0
    }

    /// Creates an angle with the specified double-precision radians.
    /// 
    /// - Parameter radians: A double-precision value that specifies the angle in radians.
    @inlinable public init(radians: Double) {
        self.degrees = radians * (180.0 / .pi)
        self.radians = radians
    }

    /// Creates an angle with the specified floating-point radians.
    /// 
    /// - Parameter radians: A floating-point value that specifies the angle in radians.
    @inlinable public init<T>(radians: T) where T : BinaryFloatingPoint {
        self.degrees = Double(radians) * (180.0 / .pi)
        self.radians = Double(radians)
    }

    /// Creates an angle with the specified double-precision degrees.
    /// 
    /// - Parameter degrees: A double-precision value that specifies the angle in degrees.
    @inlinable public init(degrees: Double) {
        self.degrees = degrees
        self.radians = degrees * (.pi / 180.0)
    }

    /// Creates an angle with the specified double-precision degrees.
    /// 
    /// - Parameter degrees: A double-precision value that specifies the angle in degrees.
    @inlinable public init<T>(degrees: T) where T : BinaryFloatingPoint {
        self.degrees = Double(degrees)
        self.radians = Double(degrees) * (.pi / 180.0)
    }

    /// Creates an angle from a double-precision floating-point literal.
    /// 
    /// - Parameter value: A double-precision floating-point literal value that specifies the angle in degrees.
    @inlinable public init(floatLiteral value: Double) {
        self.init(degrees: value)
    }
    
    /// Creates an angle from an integer literal.
    /// 
    /// - Parameter value: An integer literal value that specifies the angle in degrees.
    @inlinable public init(integerLiteral value: Int) {
        self.init(degrees: Double(value))
    }

    /// Returns a new angle structure with the specified double-precision degrees.
    /// 
    /// - Parameter degrees: The angle in degrees.
    /// - Returns: A new angle structure with the specified degrees.
    @inlinable public static func degrees(_ degrees: Double) -> Angle {
        Angle(degrees: degrees)
    }

    /// Returns a new angle structure with the specified double-precision radians.
    /// 
    /// - Parameter radians: The angle in radians.
    /// - Returns: A new angle structure with the specified radians.
    @inlinable public static func radians(_ radians: Double) -> Angle {
        Angle(radians: radians)
    }

    // MARK: - Geometry functions

    /// Returns the cosine of the specified angle.
    /// - Parameter x: The angle in radians.
    /// - Returns: The cosine of the angle.
    public static func cos(_ x: Double) -> Double {
        // Implementação da função cosseno usando série de Taylor
        // cos(x) = 1 - x^2/2! + x^4/4! - x^6/6! + ...
        var result = 1.0
        var term = 1.0
        let maxIterations = 20
        for n in 1...maxIterations {
            term *= -x * x / Double((2 * n - 1) * (2 * n))
            result += term
            if abs(term) < 1e-15 { break }
        }
        return result
    }

    /// Returns the sine of the specified angle.
    /// - Parameter x: The angle in radians.
    /// - Returns: The sine of the angle.
    public static func sin(_ x: Double) -> Double {
        // Implementação da função seno usando série de Taylor
        // sin(x) = x - x^3/3! + x^5/5! - x^7/7! + ...
        var result = x
        var term = x
        let maxIterations = 20
        for n in 1...maxIterations {
            term *= -x * x / Double((2 * n) * (2 * n + 1))
            result += term
            if abs(term) < 1e-15 { break }
        }
        return result
    }

    /// Returns the inverse cosine of the specified value.
    /// 
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse cosine of the specified value.
    public static func acos(_ x: Double) -> Angle {
        // Validação de entrada: acos é definido apenas para valores entre -1 e 1
        guard x >= -1.0 && x <= 1.0 else {
            return Angle(radians: Double.nan)
        }
        
        // Casos especiais
        if x == 1.0 { return Angle(radians: 0.0) }
        if x == -1.0 { return Angle(radians: .pi) }
        if x == 0.0 { return Angle(radians: .pi / 2.0) }
        
        // Usar a relação: acos(x) = π/2 - asin(x)
        let asinResult = asin(x)
        return Angle(radians: .pi / 2.0 - asinResult.radians)
    }

    /// Returns the inverse hyperbolic cosine of the specified value.
    /// 
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse hyperbolic cosine of the specified value.
    public static func acosh(_ x: Double) -> Angle {
        // Validação de entrada: acosh é definido apenas para x >= 1
        guard x >= 1.0 else {
            return Angle(radians: Double.nan)
        }
        
        // Caso especial
        if x == 1.0 { return Angle(radians: 0.0) }
        
        // Usar a fórmula: acosh(x) = ln(x + sqrt(x² - 1))
        // Implementar ln usando série de Taylor
        let argument = x + sqrt(x * x - 1.0)
        let result = naturalLog(argument)
        
        return Angle(radians: result)
    }
    
    // Função auxiliar para calcular logaritmo natural
    private static func naturalLog(_ x: Double) -> Double {
        guard x > 0 else { return Double.nan }
        
        if x == 1.0 { return 0.0 }
        
        // Para x próximo de 1, usar ln(1+u) = u - u²/2 + u³/3 - u⁴/4 + ...
        if x > 0.5 && x < 2.0 {
            let u = x - 1.0
            var result = u
            var term = u
            
            for n in 2...50 {
                term *= -u
                result += term / Double(n)
                if abs(term / Double(n)) < 1e-15 { break }
            }
            
            return result
        }
        
        // Para outros valores, usar propriedades do logaritmo
        if x > 2.0 {
            return naturalLog(x / 2.0) + naturalLog(2.0)
        } else {
            return -naturalLog(1.0 / x)
        }
    }
    
    // Função auxiliar para calcular raiz quadrada usando método de Newton
    private static func sqrt(_ x: Double) -> Double {
        guard x >= 0 else { return Double.nan }
        if x == 0.0 { return 0.0 }
        if x == 1.0 { return 1.0 }
        
        var guess = x / 2.0
        for _ in 0..<20 {
            let newGuess = (guess + x / guess) / 2.0
            if abs(newGuess - guess) < 1e-15 { break }
            guess = newGuess
        }
        
        return guess
    }

    /// Returns the inverse sine of the specified value.
    ///
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse sine of the specified value.
    public static func asin(_ x: Double) -> Angle {
        // Validação de entrada: asin é definido apenas para valores entre -1 e 1
        guard x >= -1.0 && x <= 1.0 else {
            return Angle(radians: Double.nan)
        }
        
        // Casos especiais
        if x == 0.0 { return Angle(radians: 0.0) }
        if x == 1.0 { return Angle(radians: .pi / 2.0) }
        if x == -1.0 { return Angle(radians: -.pi / 2.0) }
        
        // Usar série de Taylor para asin(x) = x + x³/6 + 3x⁵/40 + 15x⁷/336 + ...
        let absX = abs(x)
        var result = absX
        var term = absX
        let x2 = absX * absX
        
        // Calcular os primeiros termos da série
        for n in 1...20 {
            let numerator = Double(2 * n - 1)
            let denominator = Double(2 * n)
            term *= x2 * numerator / denominator / Double(2 * n + 1)
            result += term
            
            // Parar quando a precisão for suficiente
            if abs(term) < 1e-15 { break }
        }
        
        return Angle(radians: x < 0 ? -result : result)
    }

    /// Returns the inverse hyperbolic sine of the specified value.
    /// 
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse hyperbolic sine of the specified value.
    public static func asinh(_ x: Double) -> Angle {
        // Caso especial
        if x == 0.0 { return Angle(radians: 0.0) }
        
        // Usar a fórmula: asinh(x) = ln(x + sqrt(x² + 1))
        let absX = abs(x)
        let argument = absX + sqrt(absX * absX + 1.0)
        let result = naturalLog(argument)
        
        return Angle(radians: x < 0 ? -result : result)
    }

    /// Returns the inverse tangent of the specified value.
    ///
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse tangent of the specified value.
    public static func atan(_ x: Double) -> Angle {
        // Casos especiais
        if x == 0.0 { return Angle(radians: 0.0) }
        if x == 1.0 { return Angle(radians: .pi / 4.0) }
        if x == -1.0 { return Angle(radians: -.pi / 4.0) }
        
        let absX = abs(x)
        var result: Double
        
        if absX <= 1.0 {
            // Usar série de Taylor: atan(x) = x - x³/3 + x⁵/5 - x⁷/7 + ...
            result = absX
            var term = absX
            let x2 = absX * absX
            
            for n in 1...50 {
                term *= -x2
                let denominator = Double(2 * n + 1)
                result += term / denominator
                
                if abs(term / denominator) < 1e-15 { break }
            }
        } else {
            // Para |x| > 1, usar atan(x) = π/2 - atan(1/x)
            let reciprocal = 1.0 / absX
            var atanReciprocal = reciprocal
            var term = reciprocal
            let recip2 = reciprocal * reciprocal
            
            for n in 1...50 {
                term *= -recip2
                let denominator = Double(2 * n + 1)
                atanReciprocal += term / denominator
                
                if abs(term / denominator) < 1e-15 { break }
            }
            
            result = .pi / 2.0 - atanReciprocal
        }
        
        return Angle(radians: x < 0 ? -result : result)
    }

    /// Returns the inverse tangent of the specified values.
    /// 
    /// - Parameters:
    ///   - y: The y coordinate.
    ///   - x: The x coordinate.
    /// - Returns: A new angle structure representing the inverse tangent of y/x, considering the quadrant.
    public static func atan2(y: Double, x: Double ) -> Angle {
        // Casos especiais
        if x == 0.0 && y == 0.0 { return Angle(radians: 0.0) }
        if x == 0.0 {
            return Angle(radians: y > 0 ? .pi / 2.0 : -.pi / 2.0)
        }
        if y == 0.0 {
            return Angle(radians: x > 0 ? 0.0 : .pi)
        }
        
        let atanResult = atan(y / x)
        
        // Ajustar para o quadrante correto
        if x > 0 {
            return atanResult
        } else if x < 0 {
            if y >= 0 {
                return Angle(radians: atanResult.radians + .pi)
            } else {
                return Angle(radians: atanResult.radians - .pi)
            }
        } else {
            // x == 0
            return Angle(radians: y > 0 ? .pi / 2.0 : -.pi / 2.0)
        }
    }

    /// Returns the inverse hyperbolic tangent of the specified value.
    /// 
    /// - Parameter x: The source value.
    /// - Returns: A new angle structure representing the inverse hyperbolic tangent of the specified value.
    public static func atanh(_ x: Double) -> Angle {
        // Validação de entrada: atanh é definido apenas para -1 < x < 1
        guard x > -1.0 && x < 1.0 else {
            return Angle(radians: Double.nan)
        }
        
        // Caso especial
        if x == 0.0 { return Angle(radians: 0.0) }
        
        // Usar a fórmula: atanh(x) = (1/2) * ln((1+x)/(1-x))
        let numerator = 1.0 + x
        let denominator = 1.0 - x
        let ratio = numerator / denominator
        let result = 0.5 * naturalLog(ratio)
        
        return Angle(radians: result)
    }
}

extension Angle : Equatable {

    /// Compares two angles for equality.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    /// - Returns: A Boolean value indicating whether the two angles are equal.
    public static func == (lhs: Angle, rhs: Angle) -> Bool {
        lhs.radians == rhs.radians && lhs.degrees == rhs.degrees
    }
}

extension Angle : Comparable {

    /// Compares two angles to determine if the left-hand side angle is less than the right-hand side angle.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    /// - Returns: A Boolean value indicating whether the left-hand side angle is less than the right-hand side angle.
    public static func < (lhs: Angle, rhs: Angle) -> Bool {
        lhs.radians < rhs.radians && lhs.degrees < rhs.degrees
    }

    /// Compares two angles to determine if the left-hand side angle is greater than the right-hand side angle.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    /// - Returns: A Boolean value indicating whether the left-hand side angle is greater than the right-hand side angle.
    public static func > (lhs: Angle, rhs: Angle) -> Bool {
        lhs.radians > rhs.radians && lhs.degrees > rhs.degrees
    }
}

extension Angle : AdditiveArithmetic {

    /// A Boolean value indicating whether the angle is zero.
    public static var zero: Angle {
        Angle(radians: 0.0)
    }

    /// Adds two angles.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    /// - Returns: A new angle structure representing the sum of the two angles.
    public static func + (lhs: Angle, rhs: Angle) -> Angle {
        Angle(radians: lhs.radians + rhs.radians)
    }

    /// Subtracts one angle from another.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    /// - Returns: A new angle structure representing the difference between the two angles.
    public static func - (lhs: Angle, rhs: Angle) -> Angle {
        Angle(radians: lhs.radians - rhs.radians)
    }

    /// Adds one angle to another.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    public static func += (lhs: inout Angle, rhs: Angle) {
        lhs = lhs + rhs
    }

    /// Subtracts one angle from another.
    /// - Parameters:
    ///   - lhs: The left-hand side angle.
    ///   - rhs: The right-hand side angle.
    public static func -= (lhs: inout Angle, rhs: Angle) {
        lhs = lhs - rhs
    }
}

extension Angle : CustomStringConvertible {

    /// A string representation of the angle in radians.
    public var description: String {
        "(radians: \(radians))"
    }
}
