export default class TileDemo extends Phaser.Scene {

    constructor() {
        super('tiledemo');
        this.score = null;
    }

    init(data) {
        console.log('init', this.scene.key, data, this);
        this.score = 0;
    }

    create() {
        this.add.text(400, 300, 'TILE DEMO', {
            fill: 'white',
            fontSize: 48
        })
            .setOrigin(0.5)
            .setShadow(0, 1, '#62F6FF', 10);
    }

    update() {
        // this.score += 1;
    }

    // extend:

    quit() {
        // this.scene.start('menu', { score: this.score });
    }

}
