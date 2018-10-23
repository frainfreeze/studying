## Hello world

### python
```python
# example
print("hello world")
```

### C#
```csharp
using System;

// example
class MainClass{
	public static void Main(string[] args){
		Console.WriteLine("hello world");
	}
}
```

### CIL (release)
```csharp
.class private auto ansi '<Module>'
{
} // end of class <Module>

.class private auto ansi beforefieldinit MainClass
    extends [mscorlib]System.Object
{
    // Methods
    .method public hidebysig static 
        void Main (
            string[] args
        ) cil managed 
    {
        // Method begins at RVA 0x2050
        // Code size 11 (0xb)
        .maxstack 8

        IL_0000: ldstr "hello world"
        IL_0005: call void [mscorlib]System.Console::WriteLine(string)
        IL_000a: ret
    } // end of method MainClass::Main

    .method public hidebysig specialname rtspecialname 
        instance void .ctor () cil managed 
    {
        // Method begins at RVA 0x205c
        // Code size 7 (0x7)
        .maxstack 8

        IL_0000: ldarg.0
        IL_0001: call instance void [mscorlib]System.Object::.ctor()
        IL_0006: ret
    } // end of method MainClass::.ctor

} // end of class MainClass
```

## Arithmetic
### python
```python
a = 10
b = a + 1
b = b - 1 
print(b)
print(3/1.5)
print(a*a)
```

### C#
```csharp
using System;

class MainClass{
    public static void Main(string[] args){
		int a = 10;
		int b = a + 1;
		b = b - 1;
		Console.WriteLine(b);
		Console.WriteLine(3/1.5);
		Console.WriteLine(a*a);
	}
}
```

### CIL (release)
```csharp
.class private auto ansi '<Module>'
{
} // end of class <Module>

.class private auto ansi beforefieldinit MainClass
    extends [mscorlib]System.Object
{
    // Methods
    .method public hidebysig static 
        void Main (
            string[] args
        ) cil managed 
    {
        // Method begins at RVA 0x2050
        // Code size 34 (0x22)
        .maxstack 8

        IL_0000: ldc.i4.s 10
        IL_0002: dup
        IL_0003: ldc.i4.1
        IL_0004: add
        IL_0005: ldc.i4.1
        IL_0006: sub
        IL_0007: call void [mscorlib]System.Console::WriteLine(int32)
        IL_000c: ldc.r8 2
        IL_0015: call void [mscorlib]System.Console::WriteLine(float64)
        IL_001a: dup
        IL_001b: mul
        IL_001c: call void [mscorlib]System.Console::WriteLine(int32)
        IL_0021: ret
    } // end of method MainClass::Main

    .method public hidebysig specialname rtspecialname 
        instance void .ctor () cil managed 
    {
        // Method begins at RVA 0x2073
        // Code size 7 (0x7)
        .maxstack 8

        IL_0000: ldarg.0
        IL_0001: call instance void [mscorlib]System.Object::.ctor()
        IL_0006: ret
    } // end of method MainClass::.ctor

} // end of class MainClass
```

## Basic control flow
### python
```python
a = True
if(a):
    print(a)
```

### C#
```csharp
using System;

class MainClass{
    public static void Main(string[] args){
		bool a = true;
		if(a)
    		Console.WriteLine(a);
	}
}
```

### CIL (release)
```csharp
.class private auto ansi '<Module>'
{
} // end of class <Module>

.class private auto ansi beforefieldinit MainClass
    extends [mscorlib]System.Object
{
    // Methods
    .method public hidebysig static 
        void Main (
            string[] args
        ) cil managed 
    {
        // Method begins at RVA 0x2050
        // Code size 12 (0xc)
        .maxstack 1
        .locals init (
            [0] bool
        )

        IL_0000: ldc.i4.1
        IL_0001: stloc.0
        IL_0002: ldloc.0
        IL_0003: brfalse.s IL_000b

        IL_0005: ldloc.0
        IL_0006: call void [mscorlib]System.Console::WriteLine(bool)

        IL_000b: ret
    } // end of method MainClass::Main

    .method public hidebysig specialname rtspecialname 
        instance void .ctor () cil managed 
    {
        // Method begins at RVA 0x2068
        // Code size 7 (0x7)
        .maxstack 8

        IL_0000: ldarg.0
        IL_0001: call instance void [mscorlib]System.Object::.ctor()
        IL_0006: ret
    } // end of method MainClass::.ctor

} // end of class MainClass
```

## Function
### python
```python
def Test(str):
    print(str)

Test("hello again")
```

### C#
```csharp
using System;

class MainClass{
	public void Test(string str){
    	Console.WriteLine(str);
	}
    
    public static void Main(string[] args){
		Console.WriteLine("hello again");
	}
}
```

### CIL (release)
```csharp
.class private auto ansi '<Module>'
{
} // end of class <Module>

.class private auto ansi beforefieldinit MainClass
    extends [mscorlib]System.Object
{
    // Methods
    .method public hidebysig 
        instance void Test (
            string str
        ) cil managed 
    {
        // Method begins at RVA 0x2050
        // Code size 7 (0x7)
        .maxstack 8

        IL_0000: ldarg.1
        IL_0001: call void [mscorlib]System.Console::WriteLine(string)
        IL_0006: ret
    } // end of method MainClass::Test

    .method public hidebysig static 
        void Main (
            string[] args
        ) cil managed 
    {
        // Method begins at RVA 0x2058
        // Code size 11 (0xb)
        .maxstack 8

        IL_0000: ldstr "hello again"
        IL_0005: call void [mscorlib]System.Console::WriteLine(string)
        IL_000a: ret
    } // end of method MainClass::Main

    .method public hidebysig specialname rtspecialname 
        instance void .ctor () cil managed 
    {
        // Method begins at RVA 0x2064
        // Code size 7 (0x7)
        .maxstack 8

        IL_0000: ldarg.0
        IL_0001: call instance void [mscorlib]System.Object::.ctor()
        IL_0006: ret
    } // end of method MainClass::.ctor

} // end of class MainClass
```