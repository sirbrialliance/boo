namespace BooBinding.CodeCompletion

import System
import System.Collections
import System.Diagnostics
import System.IO
import ICSharpCode.SharpDevelop.Services
import SharpDevelop.Internal.Parser
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast as AST
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.Steps

class Resolver:
	static _typeKeywords = ("bool", "void",
	                        "single", "double",
	                        "byte", "short", "ushort", "int", "uint", "long", "ulong",
	                        "object", "string", "regex", "array", "hash", "list", "type")
	
	def CtrlSpace(parserService as IParserService, caretLine as int, caretColumn as int, fileName as string) as ArrayList:
		result = ArrayList(_typeKeywords)
		//parseInfo = parserService.GetParseInformation(fileName)
		//cu = parseInfo.MostRecentCompilationUnit as CompilationUnit
		//if cu != null:
		//	curClass = parserService.GetInnermostClass(cu, caretLine, caretColumn) as Class
		//	if 
		return result
	
	def Resolve(parserService as IParserService, expression as string, caretLine as int, caretColumn as int, fileName as string, fileContent as string) as ResolveResult:
		if expression == null or expression == '':
			return null
		
		try:
			int.Parse(expression)
			return null
		except exception as Exception:
			pass
		
		//self._caretLine = caretLineNumber
		//self._caretColumn = caretColumn
		//self._parserService = parserService
		parseInfo = parserService.GetParseInformation(fileName)
		cu = parseInfo.MostRecentCompilationUnit as CompilationUnit
		if cu == null:
			print "BooResolver: No parse information!"
			return null
		
		callingClass as Class = parserService.GetInnermostClass(cu, caretLine, caretColumn)
		returnClass as Class = null
		if callingClass == null:
			print "BooResolver: CallingClass not found!"
			return null
		if expression == "self":
			returnClass = callingClass
		return null if returnClass == null
		return ResolveResult(returnClass, parserService.ListMembers(ArrayList(), returnClass, callingClass, false))
	