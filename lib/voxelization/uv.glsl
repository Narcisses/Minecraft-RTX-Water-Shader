// Block UVs
vec2 grass(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(16, 256),
        vec2(336, 160),
        vec2(400, 80),
        vec2(400, 80),
        vec2(400, 80),
        vec2(400, 80)
    );

    // Get the corresponding uv coordinates
    // And divide by atlas size
    return uv[faceID] / vec2(1024, 512);
}

vec2 oaklog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(48, 288),
        vec2(48, 288),
        vec2(32, 288),
        vec2(32, 288),
        vec2(32, 288),
        vec2(32, 288)
    );

    return uv[faceID] / vec2(1024, 512);
}

//TODO
vec2 birchlog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(224, 16),
        vec2(224, 16),
        vec2(224, 0),
        vec2(224, 0),
        vec2(224, 0),
        vec2(224, 0)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 sprucelog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(48, 288),
        vec2(48, 288),
        vec2(32, 288),
        vec2(32, 288),
        vec2(32, 288),
        vec2(32, 288)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 darkoaklog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(288, 80),
        vec2(288, 80),
        vec2(288, 64),
        vec2(288, 64),
        vec2(288, 64),
        vec2(288, 64)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 junglelog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(464, 16),
        vec2(464, 16),
        vec2(464, 0),
        vec2(464, 0),
        vec2(464, 0),
        vec2(464, 0)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 acacialog(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(64, 80),
        vec2(64, 80),
        vec2(48, 80),
        vec2(48, 80),
        vec2(48, 80),
        vec2(48, 80)
    );

    return uv[faceID] / vec2(1024, 512);
}
//ENDTODO

vec2 oakplank(int faceID) {
    return vec2(64, 288) / vec2(1024, 512);
}

vec2 birchplank(int faceID) {
    return vec2(224, 32) / vec2(1024, 512);
}

vec2 jungleplank(int faceID) {
    return vec2(464, 32) / vec2(1024, 512);
}

vec2 acaciaplank(int faceID) {
    return vec2(80, 80) / vec2(1024, 512);
}

vec2 darkoakplank(int faceID) {
    return vec2(288, 96) / vec2(1024, 512);
}

vec2 oakleaves(int faceID) {
    return vec2(64, 112) / vec2(1024, 512);
}

vec2 glowstone(int faceID) {
    return vec2(400, 0) / vec2(1024, 512);
}

vec2 brick(int faceID) {
    return vec2(144, 144) / vec2(1024, 512);
}

vec2 restonelamp(int faceID) {
    return vec2(176, 352) / vec2(1024, 512);
}

vec2 restonelamplit(int faceID) {
    return vec2(192, 352) / vec2(1024, 512);
}

vec2 craftingtable(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(256, 80),
        vec2(64, 288),
        vec2(256, 48),
        vec2(256, 64),
        vec2(256, 48),
        vec2(256, 64)
    );
    
    return uv[faceID] / vec2(1024, 512);
}

vec2 furnace(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(384, 160),
        vec2(384, 160),
        vec2(384, 144),
        vec2(384, 144),
        vec2(384, 112),
        vec2(384, 144)
    );
    
    return uv[faceID] / vec2(1024, 512);
}

vec2 litfurnace(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(384, 160),
        vec2(384, 160),
        vec2(384, 144),
        vec2(384, 144),
        vec2(384, 128),
        vec2(384, 144)
    );
    
    return uv[faceID] / vec2(1024, 512);
}

vec2 farmland(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(368, 64),
        vec2(336, 160),
        vec2(336, 160),
        vec2(336, 160),
        vec2(336, 160),
        vec2(336, 160)
    );
    
    return uv[faceID] / vec2(1024, 512);
}

vec2 tnt(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(0, 432),
        vec2(480, 416),
        vec2(496, 416),
        vec2(496, 416),
        vec2(496, 416),
        vec2(496, 416)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 bookshelf(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(64, 288),
        vec2(64, 288),
        vec2(48, 144),
        vec2(48, 144),
        vec2(48, 144),
        vec2(48, 144)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 dispenser(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(384, 160),
        vec2(384, 160),
        vec2(384, 144),
        vec2(384, 144),
        vec2(336, 208),
        vec2(384, 144)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 dropper(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(384, 160),
        vec2(384, 160),
        vec2(384, 144),
        vec2(384, 144),
        vec2(352, 64),
        vec2(384, 144)
    );

    return uv[faceID] / vec2(1024, 512);
}

// vec2 sandstone(int faceID) {
//     vec2 uv[6] = vec2[6](
//         vec2(112, 272),
//         vec2(80, 272),
//         vec2(80, 272),
//         vec2(80, 272),
//         vec2(80, 272),
//         vec2(80, 272)
//     );

//     return uv[faceID] / vec2(1024, 512);
// }

vec2 melon(int faceID) {
    vec2 uv[6] = vec2[6](
        vec2(112, 272),
        vec2(80, 272),
        vec2(80, 272),
        vec2(80, 272),
        vec2(80, 272),
        vec2(80, 272)
    );

    return uv[faceID] / vec2(1024, 512);
}

vec2 coalore(int faceID) {
    return vec2(112, 224) / vec2(1024, 512);
}

vec2 copperore(int faceID) {
    return vec2(192, 240) / vec2(1024, 512);
}

vec2 redstoneore(int faceID) {
    return vec2(208, 352) / vec2(1024, 512);
}

vec2 lapizore(int faceID) {
    return vec2(464, 160) / vec2(1024, 512);
}

vec2 diamondore(int faceID) {
    return vec2(336, 128) / vec2(1024, 512);
}

vec2 emeraldore(int faceID) {
    return vec2(352, 112) / vec2(1024, 512);
}

vec2 deepslatecoalore(int faceID) {
    return vec2(320, 16) / vec2(1024, 512);
}

vec2 deepslatecopperore(int faceID) {
    return vec2(320, 32) / vec2(1024, 512);
}

vec2 deepslatediamondore(int faceID) {
    return vec2(320, 48) / vec2(1024, 512);
}

vec2 deepslateemeraldore(int faceID) {
    return vec2(320, 64) / vec2(1024, 512);
}

vec2 deepslategoldore(int faceID) {
    return vec2(320, 80) / vec2(1024, 512);
}

vec2 deepslateironore(int faceID) {
    return vec2(320, 96) / vec2(1024, 512);
}

vec2 deepslatelapizore(int faceID) {
    return vec2(320, 112) / vec2(1024, 512);
}

vec2 deepslateredstoneore(int faceID) {
    return vec2(320, 128) / vec2(1024, 512);
}

vec2 coalblock(int faceID) {
    return vec2(96, 224) / vec2(1024, 512);
}

vec2 emeraldblock(int faceID) {
    return vec2(352, 96) / vec2(1024, 512);
}

vec2 diamondblock(int faceID) {
    return vec2(336, 112) / vec2(1024, 512);
}

vec2 redstoneblock(int faceID) {
    return vec2(96, 352) / vec2(1024, 512);
}

vec2 lapizblock(int faceID) {
    return vec2(464, 144) / vec2(1024, 512);
}

vec2 stone(int faceID) {
    return vec2(128, 400) / vec2(1024, 512);
}

vec2 dirt(int faceID) {
    return vec2(336, 160) / vec2(1024, 512);
}

vec2 sand(int faceID) {
    return vec2(64, 368) / vec2(1024, 512);
}

vec2 redsand(int faceID) {
    return vec2(368, 336) / vec2(1024, 512);
}

vec2 cobblestone(int faceID) {
    return vec2(160, 224) / vec2(1024, 512);
}

vec2 mossycobblestone(int faceID) {
    return vec2(144, 272) / vec2(1024, 512);
}

vec2 mossystonebrick(int faceID) {
    return vec2(160, 272) / vec2(1024, 512);
}

vec2 bedrock(int faceID) {
    return vec2(176, 0) / vec2(1024, 512);
}

vec2 sponge(int faceID) {
    return vec2(96, 448) / vec2(1024, 512);
}

vec2 ice(int faceID) {
    return vec2(432, 224) / vec2(1024, 512);
}

vec2 snow(int faceID) {
    return vec2(320, 320) / vec2(1024, 512);
}

vec2 obsidian(int faceID) {
    return vec2(336, 240) / vec2(1024, 512);
}

vec2 noteblock(int faceID) {
    return vec2(480, 270) / vec2(1024, 512);
}

vec2 redwool(int faceID) {
    return vec2(80, 352) / vec2(1024, 512);
}

vec2 purplewool(int faceID) {
    return vec2(80, 336) / vec2(1024, 512);
}

vec2 limewool(int faceID) {
    return vec2(112, 256) / vec2(1024, 512);
}

vec2 greenwool(int faceID) {
    return vec2(416, 208) / vec2(1024, 512);
}

vec2 greywool(int faceID) {
    return vec2(496, 112) / vec2(1024, 512);
}

vec2 pinkwool(int faceID) {
    return vec2(240, 304) / vec2(1024, 512);
}

vec2 cyanwool(int faceID) {
    return vec2(272, 224) / vec2(1024, 512);
}

vec2 lightbluewool(int faceID) {
    return vec2(480, 208) / vec2(1024, 512);
}

vec2 magentawool(int faceID) {
    return vec2(358, 256) / vec2(1024, 512);
}

vec2 orangewool(int faceID) {
    return vec2(400, 288) / vec2(1024, 512);
}

vec2 yellowwool(int faceID) {
    return vec2(64, 464) / vec2(1024, 512);
}

vec2 bluewool(int faceID) {
    return vec2(0, 144) / vec2(1024, 512);
}

vec2 brownwool(int faceID) {
    return vec2(80, 160) / vec2(1024, 512);
}

vec2 blackwool(int faceID) {
    return vec2(240, 96) / vec2(1024, 512);
}

// Main function
vec2 getUV(int blockID, int faceID) {
    // Return uv coordinates of topleft corner of block face
    // blockID: refers to the ID of the block
    // faceID: refers to the face of the block
    //      Top: 0
    //      Bottom: 1
    //      Left: 2
    //      Right: 3
    //      Front: 4
    //      Back: 5
    
    switch(blockID)
    {
        case 1: return stone(faceID);
        case 2: return grass(faceID);
        case 3: return dirt(faceID);
        case 4: return cobblestone(faceID);
        case 17: return oaklog(faceID);
        case 18: return oakleaves(faceID);
        case 47: return bookshelf(faceID);
        case 58: return craftingtable(faceID);
        case 61: return furnace(faceID);
        case 62: return litfurnace(faceID);
        case 89: return glowstone(faceID);
    }

    // Block not supported
    return vec2(-1, -1);
}