var actionPhase = true
var buyPhase = false

var moves = {
  'actions' : 1,
  'buys' : 1,
  'money': 0
}
function endAct() {
  actionPhase = false;
  buyPhase = true;
  $('#phaseText').text('Buy Phase');
  $('#endAct').hide();
  $('#endTurn').show();
}

$(document).ready(function(){
  boardArr = $('#boardData').data('board');
  handArr = $('#boardData').data('hand');
  // console.log(handArr)
  for(i=0;i<boardArr.length;i++){
    $('#boardRow').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+boardArr[i].image+'" alt="'+boardArr[i].id+'"><p>'+boardArr[i].amount+'</p></div>')
  }
  for(i=0;i<handArr.length;i++){
    moves['money']+=handArr[i]['money_value']
    $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+handArr[i].image+'" alt="'+handArr[i].id+'"></div>')
  }
  $('#moneyText').text('Money: '+moves['money']);

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
      amount = parseInt($(this).next().text())
      $(this).next().text(amount-=1)
      console.log($(this))
      //pass this.id somewhere
      moves['buys']--;
      $('#buyText').text('Buys: '+moves['buys'])
    }
    if(moves['buys']===0||moves['money']===0){
      //click form submit
    }
  });

  $('#endAct').click(function(){
      endAct();
  });
  $('#test').click(function(){
    $.ajax({
      url: '/test',
      success: function(result){
        alert(result)
      }
    })
  })

});
