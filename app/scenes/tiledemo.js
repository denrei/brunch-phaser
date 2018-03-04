export default class TileDemo extends Phaser.Scene {

    constructor() {
        super('tiledemo');
        this.score = null;
    }

    preload() {
        var PATH_DATA = '../data/';
        var PATH_ASSETS = './';
        this.load.tilemapTiledJSON('map', PATH_DATA + 'map.json');
        this.load.tilemapTiledJSON('map2', PATH_DATA + 'map2.json');
        this.load.image('tiles', PATH_ASSETS + 'tiles.png');
        this.load.image('super-mario-16bit', PATH_ASSETS + 'super-mario-16bit.png');
        this.load.plugin('AnimatedTiles', PATH_DATA + 'AnimatedTiles.js');
    }

    create() {
        this.add.text(400, 300, 'TILE DEMO', {
            fill: 'white',
            fontSize: 48
        })
            .setOrigin(0.5)
            .setShadow(0, 1, '#62F6FF', 10);


        var map, map2, tileset, tileset2, layer1, layer2, layer3, map2layer, countdown, changed;
        this.sys.install('AnimatedTiles');
        map = this.make.tilemap({key: 'map'});

        tileset = map.addTilesetImage('tiles', 'tiles');
        tileset2 = map.addTilesetImage('super-mario-16bit', 'super-mario-16bit');
        // Add first maps three layers with corresponing tilesets (the third having a tileset of it's own)
        layer1 = map.createDynamicLayer('ground', tileset, 0, 0);
        layer2 = map.createDynamicLayer('aboveGround', tileset, 0, 0);
        layer3 = map.createDynamicLayer('another', tileset2, 0, 0);
        // Init animations on map
        this.sys.animatedTiles.init(map);

    }

    update() {
        // this.score += 1;
    }

    // extend:

    quit() {
        // this.scene.start('menu', { score: this.score });
    }

}
