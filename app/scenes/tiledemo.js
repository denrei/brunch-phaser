export default class TileDemo extends Phaser.Scene {

    constructor() {
        super('tiledemo');
        this.score = null;
    }

    preload() {
        var PATH_DATA = '../data/';
        var PATH_ASSETS = './';
        this.load.tilemapTiledJSON('map_tiledemo', PATH_DATA + 'map_tiledemo.json');
        this.load.image('tiles', PATH_ASSETS + 'tiles.png');
        this.load.image('super-mario-16bit', PATH_ASSETS + 'super-mario-16bit.png');
        this.load.plugin('AnimatedTiles', PATH_DATA + 'AnimatedTiles.js');
    }

    create() {
        this.add.text(400, 300, 'TILE DEMO', {
            fill: 'white',
            fontSize: 48
        }).setOrigin(0.5);


        var map_tiledemo, tileset, tileset2, layer1, layer2, layer3;
        this.sys.install('AnimatedTiles');
        map_tiledemo = this.make.tilemap({key: 'map_tiledemo'});

        tileset = map_tiledemo.addTilesetImage('tiles', 'tiles');
        tileset2 = map_tiledemo.addTilesetImage('super-mario-16bit', 'super-mario-16bit');

        // Add first maps three layers with corresponing tilesets (the third having a tileset of it's own)
        layer1 = map_tiledemo.createDynamicLayer('ground', tileset, 0, 0);
        layer2 = map_tiledemo.createDynamicLayer('aboveGround', tileset, 0, 0);
        layer3 = map_tiledemo.createDynamicLayer('another', tileset2, 0, 0);

        this.sys.animatedTiles.init(map_tiledemo);

    }

    update() {
        // this.score += 1;
    }

    // extend:

    quit() {
        // this.scene.start('menu', { score: this.score });
    }

}
