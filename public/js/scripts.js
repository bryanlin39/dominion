var actionPhase = true
var buyPhase = false

var moves = {
  'actions' : 1,
  'buys' : 1,
  'money': 3 //variable based on hand
}
function endAct() {
  actionPhase = false;
  buyPhase = true;
}
function endTurn() {
  //discard hand, draw 5, shuffle discard into deck if deck.length < 5
  //set money to 0, actions to 1, buys to 1
  // switch players
  actionPhase = true;
  buyPhase = false;
}

document.ready(function(){
  $('.hand_cards').click(function(){
    if(actionPhase&&moves['actions']>0){
      //do the thing
      moves['actions']--;
      $('#actText').text(moves['actions'])
    }
    if(moves['actions']===0){
      endAct();
    }
  });

  $('.board_cards').click(function(){
    if(buyPhase&&moves['buys']>0){
      //do the thing
      moves['buys']--;
      $('#buyText').text(moves['buys'])
    }
    if(moves['buys']===0||moves['money']===0){
      endTurn();
    }
  });

  $('button').click(function(){
    if (this.id = 'endAct'){
      endAct();
    }
    else if (this.id= 'endTurn'){
      endTurn();
    }
  });

});
