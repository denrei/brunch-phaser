module.exports = class DefaultScene extends Phaser.Scene {

  constructor (sceneConfig) {
    super(sceneConfig);
  }

  preload () {
    this.load.setPath('assets/');
    this.load.image('sky', 'space3.png');
    this.load.image('logo', 'phaser3-logo.png');
    this.load.image('red', 'red.png');
  }

  create () {
    const sky = this.add.image(400, 300, 'sky');
    sky.alpha = 0.5;
    const particles = this.add.particles('red');
    const emitter = particles.createEmitter({
      speed: 100,
      scale: { start: 1, end: 0 },
      blendMode: 'ADD'
    });
    const logo = this.physics.add.image(400, 100, 'logo');
    logo.setVelocity(100, 200);
    logo.setBounce(1, 1);
    logo.setCollideWorldBounds(true);
    emitter.startFollow(logo);
  }

};
