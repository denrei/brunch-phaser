export default class TileDemo extends Phaser.Scene {

    constructor() {
        super('tiledemo');
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

        var map_tiledemo, tileset, layer1;
        this.sys.install('AnimatedTiles');
        map_tiledemo = this.make.tilemap({key: 'map_tiledemo'});
        tileset = map_tiledemo.addTilesetImage('tiles', 'tiles');
        layer1 = map_tiledemo.createDynamicLayer('ground', tileset, 0, 0);
        this.sys.animatedTiles.init(map_tiledemo);

    }

}
