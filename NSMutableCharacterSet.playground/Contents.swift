//: NSMutableCharacterSet
// https://developer.apple.com/documentation/foundation/nsmutablecharacterset

import Foundation
import CoreFoundation

// MARK: Toll-Free Bridging

// 必須使用顯式轉換
let cfstr: CFString = "Hello" as CFString
let nsstr: NSString = cfstr

//cfstr.length
//(cfstr as CFString).length
(cfstr as NSString).length
nsstr.length

// Remark: Swift strings/collections 是 value types 而 Foundation types 是 reference types


// MARK: - Unicode

/*
 在 Swift 中，字符和字符串都是基於 Unicode 標量建立的，採用21位二進制進行編碼，共17個平面（除了基本多文種平面中的 UTF-16 代理對碼位外，即U+D800至U+DFFF的編碼空間），也就是說編碼範圍是U+0000-U+D7FFF 或者 U+E000-U+10FFFF
 */

let dollarSign = "\u{24}"
// $, Unicode scalar U+0024

let blackHeart = "\u{2665}"
// ♥, Unicode scalar U+2665

let sparklingHeart = "\u{1F496}"
// 💖, Unicode scalar U+1F496



// MARK: Get Unicode scalar value

//let str = "af"
//print(str.unicodeScalars)
//
//for letter in str {
//   print(letter.unicodeScalars)
//}
//
//for val in str.unicodeScalars {
//    print(val.value)
//}
//
//for val in str.unicodeScalars {
//   print("\(val.value) ", terminator: "")
//}

// UnicodeScalarView 是 UnicodeScalar 的集合
// https://developer.apple.com/documentation/swift/string/unicodescalarview


// UTF是 Unicode Transformation Formate的縮寫,直譯過來就是Unicode格式轉換
// 每種語言對空間的需求都不一樣，像ASCII字符集在Unicode上使用起來並不高效，因為ASCII並不需要Unicode上多出來的空間，所以就有了UTF(Unicode格式轉換)，來生成一些小一點的Unicode，如UTF-8,UTF-16,UTF-32

// MARK: 表示法比較
/*
 let dogString = "Dog!!🐶"
 
 // UTF-8 表示法
 print("\n  \nUTF-8 表示法::")
 for codeUnit in dogString.utf8 {
 print("\(codeUnit) ", terminator: "")
 }
 
 print("\n前三個十進制 codeUnit值 ( 68, 111, 103)表示了字符 D , o , 和 g ，它們的 UTF-8 表示法與它們的 ASCII 表示法相同\n接下來的三個十進制 codeUnit值 ( 226, 128, 188)是 DOUBLE EXCLAMATION MARK字符的三字節 UTF-8 表示法\n最後四個 codeUnit值 ( 240, 159, 144, 182)是 DOG FACE字符的四字節 UTF-8 表示法")
 
 // UTF-16 表示法
 print("\n  \nUTF-16 表示法::")
 for codeUnit in dogString.utf16 {
 print("\(codeUnit) ", terminator: "")
 }
 print("\n前三個 codeUnit值 ( 68, 111, 103)表示了字符 D , o , 和 g，它們的 UTF-16 碼元與字符串 UTF-8 表示法中的值相同（因為這些 Unicode 標量表示 ASCII 字符）\n第四個 codeUnit值( 8252)是與十六進制值 203C相等的十進制數字，它表示了 DOUBLE EXCLAMATION MARK字符的 Unicode 標量 U+203C 。這個字符可以在 UTF-16 中表示為單個碼元了\n第五和第六個 codeUnit值 ( 55357和 56374)是 UTF-16 16位碼元對表示的 DOG FACE字符。這些值是高16位碼元值 U+D83D（十進制值為 55357）和低16位碼元值 U+DC36（十進制值為 56374)")
 
 // Unicode Scalar 表示法
 print("\n  \nUnicode Scalar 表示法::")
 for scalar in dogString.unicodeScalars {
 print("\(scalar.value) ", terminator: "")
 }
 print("\n前三個 UnicodeScalar值的 value屬性 ( 68, 111, 103) 還是表示了字符 D, o, 和 g。\n第四個 codeUnit值 ( 8252)還是等於十六進制值 203C的十進制值，它表示了 DOUBLE EXCLAMATION MARK字符的 Unicode 標量 U+203C。\n第五個和最後一個 UnicodeScalar的 value屬性， 128054，是一個等於十六進制值 1F436的十進制數字，它表示了 DOG FACE字符的 Unicode 標量 U+1F436。")
 */

// Mark: CharacterSet.init

// CharacterSet.init(charactersIn: String)
let str_1 = CharacterSet.init(charactersIn: "aeiou")

// CharacterSet.init(charactersIn: Range<Unicode.Scalar>)
let str_2 = CharacterSet.init(charactersIn: "\u{10000}" ..< "\u{10001}")

// CharacterSet.init(charactersIn: ClosedRange<Unicode.Scalar>)
let str_3 = CharacterSet.init(charactersIn: "\u{10000}" ... "\u{10001}")

// Method on stackoverflow

// What is the best way to test if a CharacterSet contains a Character in Swift 4?
// https://stackoverflow.com/questions/45872368/what-is-the-best-way-to-test-if-a-characterset-contains-a-character-in-swift-4

//class MyScanner {
//    let string: String
//    var index: String.Index
//
//    init(_ string: String) {
//        self.string = string
//        index = string.startIndex
//    }
//
//    var remains: String { return String(string[index...]) }
//
//    func skip(charactersIn skipString: String) {
//        while index < string.endIndex, skipString.contains(string[index]) {
//            index = string.index(index, offsetBy: 1)
//        }
//    }
//
//    func skip(charactersIn characterSet: CharacterSet) {
//        while index < string.endIndex,
//            string[index].unicodeScalars.count == 1,
//            let character = string[index].unicodeScalars.first,
//            characterSet.contains(character) {
//                index = string.index(index, offsetBy: 1)
//        }
//    }
//
//}
//
//let scanner = MyScanner("fizz  buzz fizz")
//scanner.skip(charactersIn: CharacterSet.alphanumerics)
//scanner.skip(charactersIn: CharacterSet.whitespaces)
//print("what remains: \"\(scanner.remains)\"")
//
//let scanner2 = MyScanner("fizz 🇯🇵🇯🇵  buzz fizz")
//scanner.skip(charactersIn: CharacterSet.alphanumerics)
//scanner.skip(charactersIn: CharacterSet.whitespaces)
//print("what remains: \"\(scanner.remains)\"")




// MARK: - Method

// Swift3: CharacterSet <- NSCharacterSet, NSMutableCharacterSet
// https://developer.apple.com/documentation/foundation/characterset

var stringA = CharacterSet.init(charactersIn: "aeiou")
//print(stringA)
stringA.remove(charactersIn: "a")
//print(stringA)


let stringB = "A for Apple"
stringB.components(separatedBy: .uppercaseLetters)
stringB.components(separatedBy: .uppercaseLetters).joined()
stringB.components(separatedBy: .whitespaces)
stringB.components(separatedBy: .whitespaces).joined()


let characterSet = CharacterSet.init(charactersIn: "A")
characterSet.inverted

let stringC = "A for Apple"
stringC.components(separatedBy: characterSet)
stringC.components(separatedBy: characterSet.inverted)


// MARK: 刪除String前後的空格

let str1 = "  Oh    no there   are  too many    spaces. "
// 除去前後空格
let str2 = str1.trimmingCharacters(in: .whitespaces)

//print("原字符串：\(str1)")
//print("新字符串：\(str2)")


// MARK:刪除前後指定的字符

let strA = "<<Oh    no>o>"

//刪除前後<>
let characterSet1 = CharacterSet(charactersIn: "<>")
let strB = strA.trimmingCharacters(in: characterSet1)

//print("原字符串：\(strA)")
//print("新字符串：\(strB)")

// MARK: 刪除及提取指定的字符

extension String {
    // 從String中刪除 CharacterSet
    func remove(characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
    
    // 從String中取出 CharacterSet
    func extract(characterSet: CharacterSet) -> String {
        return remove(characterSet: characterSet.inverted)
    }
    
}


var testString = "我們一起學貓叫 一起😺😺😺😺😺\n 123 ❀☞☞☞meow meow Åström 﨣 ❀ YEAH! Very Good. \r がぎぐげごぱぴぷぺぽ ⓴"

// 普通字符 + 數字 + 可分解字符
print("alphanumerics::: ", testString.extract(characterSet: .alphanumerics))
// 普通字符（字母，假名，漢字等）
print("letters::: ", testString.extract(characterSet: .letters))
// 可分解（通過組合多個字符形成的字符）
print("decomposables::: ", testString.extract(characterSet: .decomposables))
// 大寫
print("uppercaseLetters::: ", testString.extract(characterSet: .uppercaseLetters))
// 小寫
print("lowercaseLetters::: ", testString.extract(characterSet: .lowercaseLetters))
// 數字（包括全型數字）
print("decimalDigits::: ", testString.extract(characterSet: .decimalDigits))
// 標點
print("punctuationCharacters::: ", testString.extract(characterSet: .punctuationCharacters))
// 符號（Unicode Private Use Area中的字符除外）
print("symbols::: ", testString.extract(characterSet: .symbols))
// 空格
print("whitespaces::: ", testString.extract(characterSet: .whitespaces))
// 空格+換行
print("whitespacesAndNewlines::: ", testString.extract(characterSet: .whitespacesAndNewlines))
// 換行
print("newlines::: ", testString.extract(characterSet: .newlines))
// 控制符
print("controlCharacters::: ", testString.extract(characterSet: .controlCharacters))
// 大寫
print("capitalizedLetters)::: ", testString.extract(characterSet: .capitalizedLetters))
// 非字符+非法字符
print("illegalCharacters::: ", testString.extract(characterSet: .illegalCharacters))
// 非基礎
print("nonBaseCharacters::: ", testString.extract(characterSet: .nonBaseCharacters))

//print(testString)

testString = testString.remove(characterSet: .symbols)

//print(testString)


let ting0 = "t" + "\u{0069}" + "ng"
let ting1 = "t" + "\u{0069}" + "\u{0304}" + "ng"
let ting2 = "t" + "\u{012B}" + "ng"

ting0.extract(characterSet: .decomposables)
ting1.extract(characterSet: .decomposables)
ting2.extract(characterSet: .decomposables)

// MARK: 檢查character set是否是子集

let newSet = CharacterSet(charactersIn: "a")
newSet.isSubset(of: CharacterSet.decimalDigits)
newSet.isSubset(of: CharacterSet.alphanumerics)



// MARK: 刪除多餘空格要先刪除空字串
var string = "  Oh    no there   are  too many    spaces. "

// 在空格處將字符串分割成一個array
let components = string.components(separatedBy: .whitespaces)
components.count

// 在array中去除空字串再用單個空格將array重新拼成string
string = components.filter{ !$0.isEmpty }.joined(separator: " ")

//print(string)

// MARK: 刪除多餘空格要先刪除空字串

//var string = "  A  for    Apple  "
//string.count
//// 在空格處將字符串分割成一個array
//let components = string.components(separatedBy: .whitespaces)
//components.count
//
//// 在array中去除空字串再用單個空格將array重新拼成string
//string = components.filter{ !$0.isEmpty }.joined(separator: ",")
//
////print(string)
//
//
//var string2 = "A for Apple"
//string2.count
//
//// 在空格處將字符串分割成一個array
//let components2 = string2.components(separatedBy: .whitespaces)
//components2.count
//
//// 在array中去除空字串再用單個空格將array重新拼成string
//string2 = components2.filter{ !$0.isEmpty }.joined(separator: ",")

//print(string2)



var string2 = "３時に友達と会う"
let components2 = string2.components(separatedBy: .whitespaces)

//print(components2)

// 👆對於不使用空格分隔單詞的語言根本不起作用



// MARK: 分割單詞


// MARK: 用空格分割字符串
var characters = NSCharacterSet.whitespacesAndNewlines
let punctuation = NSCharacterSet.punctuationCharacters
characters.formUnion(punctuation)
characters.remove(charactersIn: " ")

let input = "  Oh    no there   are  too many    spaces. "

let words = input.components(separatedBy: characters)

let componentsSeparatedByCharactersInSet = words.filter({ !$0.isEmpty })
//print(componentsSeparatedByCharactersInSet)



// MARK: 檢查是否字串包括某些字符集

extension String {
    
    // 檢查字串是否包括元音
    func hasVowels() -> Bool {
        let vowels = CharacterSet.init(charactersIn: "aeiou")
        
        if rangeOfCharacter(from: vowels) != nil{
            return true
        } else {
            return false
        }
    }
    
    // 檢查字串是否包括指定字符集
    func hasValue(characterSet: CharacterSet) -> Bool {
        if rangeOfCharacter(from: characterSet) != nil{
            return true
        } else {
            return false
        }
    }
    
}

let fullword = "mathematics"
let shortterm = "math"
let test = "ddddd"

fullword.hasVowels()
shortterm.hasVowels()
fullword.hasValue(characterSet: CharacterSet(charactersIn: shortterm))
test.hasVowels()
test.hasValue(characterSet: CharacterSet(charactersIn: "a"))



/*
 CharacterSet.urlHostAllowed等類型包含了所有不需要被轉碼的字符，反過來說就是指明瞭需要被轉碼的字符
 需要被轉碼的字符:
 * CharacterSet.urlHostAllowed: "#%/<>?@\^`\{\|\}
 * CharacterSet.urlPathAllowed: "#%;<>?[\]^`\{\|\}
 * CharacterSet.urlUserAllowed:  #%/<>?@\^`\{\|\}
 * CharacterSet.urlQueryAllowed: "#%<>[\]^`\{\|\}
 * CharacterSet.urlPasswordAllowed:  "#%/:<>?@[\]^`\{\|\}
 
 */

//  * CharacterSet.urlHostAllowed: "#%/<>?@\^`\{\|\}
CharacterSet.urlHostAllowed.contains("1")
CharacterSet.urlHostAllowed.contains("@")
CharacterSet.urlHostAllowed.contains("-")

// 所有類型的URL中,"-_.~"都不應該被轉碼
// Returns a new string created by replacing all characters in the string not in the specified set with percent encoded characters.
var str = "-_.~"
var encodeStr = str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""

var str2 = "@"
var encodeStr2 = str2.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""


// 自定義不需要被encode的字符
let str3 = "#/%/<>?@"
let custom = CharacterSet(charactersIn: "#")
let encodeString = str3.addingPercentEncoding(withAllowedCharacters: custom) ?? ""


let custom2 = CharacterSet(charactersIn: "#").inverted
let encodeString2 = str3.addingPercentEncoding(withAllowedCharacters: custom2) ?? ""




// MARK: Tokenizer
// https://developer.apple.com/documentation/corefoundation/cfstringtokenizer-rf8

extension String {
    // 分詞
    func tokenize() -> [String] {
        // 當前分詞的位置
        var range: CFRange?
        // 儲存分好的詞的array
        var tokens : [String] = []
        // 第三個參數 range， 字符串string需要提取分詞的範圍，一般是整個string
        let inputRange = CFRangeMake(0, string.count)
        // 第四個參數 options, 設置分詞標準
        let flag = kCFStringTokenizerUnitWordBoundary
        // 創建分詞器（Tokenizer）
        let tokenizer = CFStringTokenizerCreate( nil, self as CFString, inputRange, flag, nil)
        // 提取分詞位置
        CFStringTokenizerAdvanceToNextToken(tokenizer)
        // 獲取第一個分詞的範圍
        range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
        
        var token = ""
        while (range?.length ?? 0) > 0 {
            token = (string as NSString).substring(with: NSRange(location: range?.location ?? 0, length: range?.length ?? 0))
            tokens.append(token)
            CFStringTokenizerAdvanceToNextToken(tokenizer)
            range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
        }
        return tokens
    }
    // 取得指定Range內的詞
    func substringWithRange(aRange : CFRange) -> String {
        let nsrange = NSMakeRange(aRange.location, aRange.length)
        let substring = (self as NSString).substring(with: nsrange)
        return substring
    }
}

var stringN = "３時に友達と会う"

stringN.tokenize()
stringN.substringWithRange(aRange: CFRangeMake(0, 2))
stringN.substringWithRange(aRange: CFRangeMake(3, 5))
stringN.substringWithRange(aRange: CFRangeMake(3, 4))

// TODO: 研究 CFRange


// 儲存分好的詞的array
var keywords: [AnyHashable] = []

// 創建分詞器（Tokenizer）
// 第一個參數 alloc，一般傳入nil(使用當前默認的CFAllocator)即可
// 第二個參數 string，傳入將要被提取分詞的字符串(__bridge CFStringRef)string
// 第三個參數 range， 字符串string需要提取分詞的範圍，一般是整個string
/* 第四個參數 options, 設置分詞標準，比較實用的是kCFStringTokenizerUnitWordBoundary
 CFOptionFlags有以下枚舉：
 kCFStringTokenizerUnitWord                           = 0,
 kCFStringTokenizerUnitSentence                       = 1,
 kCFStringTokenizerUnitParagraph                      = 2,
 kCFStringTokenizerUnitLineBreak                      = 3,
 kCFStringTokenizerUnitWordBoundary                   = 4,
 kCFStringTokenizerAttributeLatinTranscription        = 1UL << 16,
 kCFStringTokenizerAttributeLanguage                  = 1UL << 17,
 */
// 第五個參數 locale, 本地化，可指定特殊的語言或區域，nil為自動識別
var ref = CFStringTokenizerCreate(nil, string as CFString?, CFRangeMake(0, string.count), kCFStringTokenizerUnitWordBoundary, nil)

// 當前分詞的位置
var range: CFRange?

// 提取分詞位置
CFStringTokenizerAdvanceToNextToken(ref)
// 獲取第一個分詞的範圍
range = CFStringTokenizerGetCurrentTokenRange(ref)

// 循環遍歷獲取所有分詞並記錄到數組中
var keyWord = ""
while (range?.length ?? 0) > 0 {
    keyWord = (string as NSString).substring(with: NSRange(location: range?.location ?? 0, length: range?.length ?? 0))
    keywords.append(keyWord)
    CFStringTokenizerAdvanceToNextToken(ref)
    range = CFStringTokenizerGetCurrentTokenRange(ref)
    //print("\(keyWord)")
}
//print("all = \(keywords)")












