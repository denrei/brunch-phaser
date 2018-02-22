window.game = new Phaser.Game({

  type: Phaser.AUTO,

  width: 800,

  height: 600,

  physics: {
    default: 'arcade',
    arcade: {
      gravity: { y: 180 }
    }
  },

  scene: require('scenes/default')

});
