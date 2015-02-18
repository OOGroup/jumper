function GameObject(x, y, width, height) {
	this.x = x;
	this.y = y;
	this.width = width;
	this.height = height;
}

function Wall(x, y, width, height) {
	//GameObject.apply(this, arguments);
	this.inheritFrom = GameObject;
	this.inheritFrom(x, y, width, height);
	/*
	this.x = x;
	this.y = y;
	this.width = width;
	this.height = height;
	*/
	this.moving = true;

	this.draw = function(){
		var c = document.getElementById("gameCanvas");
		var ctx = c.getContext("2d");
		ctx.fillStyle = "#FF0000";
		ctx.fillRect(c.width-this.x,c.height-this.y,this.width,this.height);		
	}
}

function Person(x, y, width, height) {
	//GameObject.apply(this, arguments);
	this.inheritFrom = GameObject;
	this.inheritFrom(x, y, width, height);

	this.moving = true;

	this.draw = function(){
		var c = document.getElementById("gameCanvas");
		var ctx = c.getContext("2d");
		ctx.fillStyle = "#F00000";
		ctx.fillRect(this.x,this.y,this.width,this.height);		
	}	
}

function Level(objs) {
	this.objects = objs;

	this.drawLevel = function(){
		var l = this.objects.length
		for (var i = 0; i < l; i++){
			this.objects[i].draw();
		}		
	}
}

function GameController(l) {
	this.levels = l;
	this.currentLevel = 0;

	this.startLevel = function(level){
		this.levels[level].drawLevel();		
	}
}

function drawShit(){
	Wall.prototype = Object.create(GameObject.prototype);
	var wall = new Wall(75,75,75,75);
	var person = new Person(0,0,75,75);
	var test = (person instanceof GameObject);
	var l = new Level([wall, person]);
	var g = new GameController([l])
	g.startLevel(0);
}

drawShit();

