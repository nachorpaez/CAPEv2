rule Formbook
{
    meta:
        author = "kevoreilly"
        description = "Formbook Anti-hook Bypass"
        cape_options = "bp0=$remap_ntdll_0,action0=setedx:ntdll,count0=1,bp1=$remap_ntdll_1,action1=setptr:esi+12::ntdll,count1=1"
        packed = "9e38c0c3c516583da526016c4c6a671c53333d3d156562717db79eac63587522"
        packed = "b8e44f4a0d92297c5bb5b217c121f0d032850b38749044face2b0014e789adfb"
    strings:
        $remap_ntdll_0 = {33 56 04 8D 86 [2] 00 00 68 F0 00 00 00 50 89 56 ?? E8 [4] 8B [1-5] 6A 00 6A 04 8D 4D ?? 51 6A 07 52 56 E8 [4] 8B 45 ?? 83 C4 20 3B}
        $remap_ntdll_1 = {33 56 0C 8D 86 [2] 00 00 68 F0 00 00 00 50 89 56 ?? E8 [4] 8B [1-5] 6A 00 6A 04 8D 4D ?? 51 6A 07 52 56 E8 [4] 8B 45 ?? 83 C4 20 3B}
    condition:
        any of them
}

rule FormconfA
{
    meta:
        author = "kevoreilly"
        description = "Formbook Config Extraction"
        cape_options = "clear,bp0=$c2,action0=string:rcx+1,bp1=$decoy+67,action1=string:rcx+1,count=0,typestring=Formbook Config"
        packed = "b8e44f4a0d92297c5bb5b217c121f0d032850b38749044face2b0014e789adfb"
    strings:
        $c2 = {44 8B C6 48 8B D3 49 8B CE E8 [4] 44 88 23 41 8B DD 48 8D [2] 66 66 66 0F 1F 84 00 00 00 00 00 BA 8D 00 00 00 41 FF C4}
        $decoy = {8B D7 0F 1F 44 00 00 0F B6 03 FF C0 48 98 48 03 D8 48 FF CA 75 ?? 44 0F B6 03 48 8D 53 01 48 8D 4C [2] E8}
    condition:
        all of them
}

rule FormconfB
{
    meta:
        author = "kevoreilly"
        description = "Formbook Config Extraction"
        cape_options = "clear,bp0=$c2,action0=string:rcx+1,bp1=$decoy,action1=string:rcx+1,bp2=$config,action2=scan,count=0,typestring=Formbook Config"
        packed = "ad81131f4f7e0ca1b4b89f17e63d766b1b4c18d1cb873db08de57ed86f9bb140"
    strings:
        $c2 = {44 0F B6 5D ?? 45 84 DB 74 ?? 48 8D 4D [1-5] 41 80 FB 2F 74 11 0F B6 41 01 48 FF C1 FF C3 44 0F B6 D8 84 C0 75}
        $decoy = {45 3B B5 [2] 00 00 44 8D 1C 33 48 8D 7D ?? 42 C6 44 [2] 00 49 0F 44 FF 48 8B CF E8}
        $config = {40 55 53 56 57 41 54 41 55 41 56 41 57 48 8D AC 24 [4] 48 81 EC [2] 00 00 45 33 F6 33 C0 4C 8B E9 4C 89 75}
    condition:
        any of them
}
