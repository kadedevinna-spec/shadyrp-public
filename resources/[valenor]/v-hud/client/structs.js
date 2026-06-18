
// ==================== NOTIFICATION EXPORTS ====================
// Left-side notification with icon
exports('LeftNot', (title, desc, dict, txtr, timer) => {
    const struct1 = new DataView(new ArrayBuffer(48));
    struct1.setInt32(0, timer, true);
    const string1 = CreateVarString(10, "LITERAL_STRING", title);
    const string2 = CreateVarString(10, "LITERAL_STRING", desc);
    const struct2 = new DataView(new ArrayBuffer(56));
    struct2.setBigInt64(8, BigInt(string1), true);
    struct2.setBigInt64(16, BigInt(string2), true);
    struct2.setBigInt64(32, BigInt(GetHashKey(dict)), true);
    struct2.setBigInt64(40, BigInt(GetHashKey(txtr)), true);
    struct2.setBigInt64(48, BigInt(GetHashKey("COLOR_WHITE")), true);
    Citizen.invokeNative("0x26E87218390E6729", struct1, struct2, 1, 1);
});

// Right-side notification with icon and sound
exports('RightNot', (text, dict, icon, text_color, duration) => {
    const _text = CreateVarString(10, "LITERAL_STRING", text);
    const _dict = CreateVarString(10, "LITERAL_STRING", dict);
    const sdict = CreateVarString(10, "LITERAL_STRING", "Transaction_Feed_Sounds");
    const sound = CreateVarString(10, "LITERAL_STRING", "Transaction_Positive");

    const struct1 = new DataView(new ArrayBuffer(48));
    struct1.setInt32(0, duration, true);
    struct1.setBigInt64(8, BigInt(sdict), true);
    struct1.setBigInt64(16, BigInt(sound), true);

    const struct2 = new DataView(new ArrayBuffer(76));
    struct2.setBigInt64(8, BigInt(_text), true);
    struct2.setBigInt64(16, BigInt(_dict), true);
    struct2.setBigInt64(24, BigInt(GetHashKey(icon)), true);
    struct2.setBigInt64(40, BigInt(GetHashKey(text_color)), true);
    struct2.setInt32(48, 0, true);

    Citizen.invokeNative("0xB249EBCB30DD88E0", struct1, struct2, 1);
});

// ==================== MOVE NETWORK HANDLERS ====================
on("v-hud:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", (args) => {
    // args[0] = Ped (PlayerPedId())
    // args[1] = MoveNetwork name (e.g., "Script_Mini_Game_Bathing_Regular")
    // args[2] = Clipset hash (e.g., `CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR`)
    // args[3] = Default hash (usually `DEFAULT`)
    // args[4] = Task name (e.g., "BATHING")

    const ped = args[0];
    const moveNetworkName = args[1];
    const clipsetHash = args[2];
    const defaultHash = args[3];
    const taskName = args[4];

    // Create DataView struct (512 bytes as per research)
    const struct = new DataView(new ArrayBuffer(512));

    // Set clipset hash at offset 0
    struct.setBigInt64(0, BigInt(clipsetHash), true);

    // Set default hash at offset 8
    struct.setBigInt64(8, BigInt(defaultHash), true);

    // Set task name string at offset 240
    const taskString = CreateVarString(10, "LITERAL_STRING", taskName);
    struct.setBigInt64(240, BigInt(taskString), true);

    // Invoke the native: TaskMoveNetworkByNameWithInitParams
    // 0x139805C2A67C4795 - TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS
    Citizen.invokeNative("0x139805C2A67C4795", ped, moveNetworkName, struct, 0.0, 0, 0, 0);
});

// Handler for TaskMoveNetworkAdvancedByNameWithInitParams (for rag entity with position)
// Native hash: 0x7B6A04F98BBAFB2C
on("v-hud:TASK_MOVE_NETWORK_ADVANCED", (args) => {
    const entity = args[0];
    const moveNetworkName = args[1];
    const clipsetHash = args[2];
    const defaultHash = args[3];
    const taskName = args[4];
    const position = args[5]; // {x, y, z}
    const heading = args[6];

    const struct = new DataView(new ArrayBuffer(512));
    struct.setBigInt64(0, BigInt(clipsetHash), true);
    struct.setBigInt64(8, BigInt(defaultHash), true);

    const taskString = CreateVarString(10, "LITERAL_STRING", taskName);
    struct.setBigInt64(240, BigInt(taskString), true);

    // Invoke advanced native with position parameters
    // 0x7B6A04F98BBAFB2C - TASK_MOVE_NETWORK_ADVANCED_BY_NAME_WITH_INIT_PARAMS
    try {
        Citizen.invokeNative("0x7B6A04F98BBAFB2C", entity, moveNetworkName,
            position.x, position.y, position.z, heading, struct, 0.0, 0, 0, 0);
    } catch (e) {
        // Advanced MoveNetwork not needed
    }
});
