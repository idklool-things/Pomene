package idk;
import hscript.Parser;
import hscript.Interp;
#if openfl
import openfl.utils.Assets;
#end

using StringTools;

enum ScriptError {
    ParseError(msg:String, line:Int);
    RuntimeError(msg:String, stack:String);
    FileError(path:String, msg:String);
}

class Script {
    public var parser:Parser;
    public var interp:Interp;
    public var onError:ScriptError->Void;
    static var globalVariables:Map<String, Dynamic> = new Map();
    static final blacklist:Array<String> = [];
    
    public function new()
    {
        if (globalVariables == null) globalVariables = new Map();
        interp = new Interp();
        parser = new Parser();
        parser.allowJSON = parser.allowTypes = parser.allowMetadata = true;
        preset();
    }
    
    public function execute(script:String)
    {
        try {
            interp.execute(parser.parseString(script));
        } catch(e) {
            if (onError != null)
                handleError(ParseError(e.message, parser.line));
        }
    }
    
    public function fromFile(script:String):Bool {
        try {
            var content = Util.getContent(script);
            try {
                interp.execute(parser.parseString(content, script));
                return true;
            } catch (e) {
                if (onError != null)
                    handleError(ParseError(e.message, parser.line));
                return false;
            }
        } catch (e) {
            if (onError != null)
                handleError(FileError(script, e.message));
            return false;
        }
    }

    public function preset()
    {
        set('Date', Date);
        set('DateTools', DateTools);
        set('Math', Math);
        set('Reflect', Reflect);
        set('Std', Std);
        set('StringTools', StringTools);
        set('Type', Type);
        #if openfl
        set('Assets', Assets);
        #end
        #if flixel
        set('FlxColor', idk.utils.ColorUtil);
        set('FlxPoint', idk.utils.ScriptPoint);
        #end
        #if sys
        set('FileSystem', sys.FileSystem);
        set('File', sys.io.File);
        #end
        set('setGlobal', (id:String, value:Dynamic) -> globalVariables.set(id, value));
        set('getGlobal', (id:String) -> globalVariables.get(id));
    }

    public function call(func:String, ?args:Array<Dynamic>)
    {
        if (interp.variables.exists(func))
        {
            try
            {
                return args == null ? Reflect.callMethod(null, get(func), []) : Reflect.callMethod(null, get(func), args);
            }
            catch (e)
            {
                if (onError != null)
                    handleError(RuntimeError(e.message, getStack()));
            }
        }
        return null;
    }
    
    public function setClassVars(obj:Dynamic, ?functions:Bool)
    {
        if (interp.classObjects == null) interp.classObjects = []; // Melhor prevenir do que remediar
        interp.classObjects.push(obj);
    }
    public function get(id:String)
    {
        if (isBlacklisted(id)) return null;
        return interp.variables.get(id);
    }
    public function set(id:String, obj:Dynamic)
    {
        if (isBlacklisted(id)) return;
        interp.variables.set(id, obj);
    }
    public function exists(id:String)
    {
        return interp.variables.exists(id);
    }
    public function destroy()
    {
        interp = null;
        parser = null;
        onError = null;
    }

    public function handleError(error:ScriptError):Void {
        if (onError != null) {
            onError(error);
        }
        trace(errorToString(error));
    }

    function isBlacklisted(n:String)
    {
        return blacklist.indexOf(n) != -1;
    }

    function getStack()
    {
        return haxe.CallStack.toString(haxe.CallStack.exceptionStack());
    }

    public function getScripts(library:String):Array<String>
    {
        return Util.readDirectory(library).filter(script -> script.endsWith('.hscript') || script.endsWith('.hx') || script.endsWith('.hxc') || script.endsWith('.hxs'));
    }

    function errorToString(error:ScriptError):String {
        return switch (error) {
            case ParseError(msg, line): 'ParseError: $msg (line $line)';
            case RuntimeError(msg, stack): 'RuntimeError: $msg\nStack: $stack';
            case FileError(path, msg): 'FileError: $msg (file: $path)';
        }
    }
}