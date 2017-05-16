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
  $('#phaseText').text('Buy Phase');
  $('#endAct').hide();
  $('#endTurn').show();
}


$(document).ready(function(){
  boardArr = $('#boardData').data('board')
  console.log(boardArr)
  for(i=0;i<boardArr.length;i++){
    $('#boardRow').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+boardArr[i].image+'"><p>Amount: '+boardArr[i].amount+'</p></div>')
  }



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
      //click form submit
    }
  });

  $('#endAct').click(function(){
      endAct();
  });

});
