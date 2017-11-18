
func assertionMessage(
    with function: String = #function,
         file: String = #file,
         line: Int = #line,
         description: String ...
    ) -> String {
    
    return [
        "function: \(function)",
        "file: \(file)",
        "line: \(line)",
        "description: \(description)",
        ].joined(separator: "\n")
}


