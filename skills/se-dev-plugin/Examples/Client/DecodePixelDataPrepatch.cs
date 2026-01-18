using System.Linq;
using ClientPlugin.Tools;
using Mono.Cecil;
using Mono.Cecil.Cil;

namespace ClientPlugin.Patches.ImageProcessing;

/*
Fix of DecodePixelData in SixLabors.ImageSharp developed by @SpaceGT.
The issue is that the original code expects `stream.Read()` to always
returns all the bytes requested, but this is not guaranteed on .NET Core.
*/
public static class DecodePixelDataPrepatch
{
    public static void Prepatch(AssemblyDefinition asmDef)
    {
        if (asmDef.Name.Name != "SixLabors.ImageSharp")
            return;

        var decoderType = asmDef.MainModule.Types.First(t =>
            t.FullName == "SixLabors.ImageSharp.Formats.Png.PngDecoderCore"
        );

        var method = decoderType.Methods.First(m =>
            m.Name == "DecodePixelData" && m.HasGenericParameters
        );

        var il = method.Body.Instructions;
        il.RecordOriginalCode(method);
        il.VerifyCodeHash(method, "8e787d98");

        // Target is the first instruction in the method
        var target = il[1];

        foreach (var instr in il)
            if (instr.OpCode == OpCodes.Ret)
            {
                instr.OpCode = OpCodes.Br;
                instr.Operand = target;
                break;
            }

        il.RecordPatchedCode(method);
    }
}