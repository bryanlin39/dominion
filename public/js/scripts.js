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
    $('#boardRow').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+boardArr[i].image+'" alt="'+boardArr[i].id+'" data-cost='+boardArr[i].cost+'><p>'+boardArr[i].amount+'</p></div>')
  }
  for(i=0;i<handArr.length;i++){
    moves['money']+=handArr[i]['money_value']
    $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card hand_cards" src="'+handArr[i].image+'" alt="'+handArr[i].deck_id+'" data-rules='+handArr[i].rules+' data-type='+handArr[i].card_type+'></div>')
  }
  $('#moneyText').text('Money: '+moves['money']);

  $('body').on('click', 'img.hand_cards', function(){
    if(actionPhase && moves['actions']>0 && $(this).data('type')=='action'){
      console.log('action')
      $.ajax({
        url: '/discard',
        data: {'deck_id':this.alt},
        success: function() {
        }
      })
      rules=$(this).data('rules').toString();
      console.log(moves, 'before')
      moves['actions'] += parseInt(rules[1])
      moves['buys'] += parseInt(rules[2])
      moves['money']=0;
      moves['money'] += parseInt(rules[0])


      $.ajax({
        url: '/draw',
        data: {'id':$('#boardData').data('player'),'number_to_draw':parseInt(rules[3])},
        dataType: 'json',
        success: function(result){
          $('#handDiv').empty();
          for(i=0;i<result.length;i++){
            moves['money']+=result[i]['money_value']
            $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card hand_cards" src="'+result[i].image+'" alt="'+result[i].deck_id+'" data-rules='+result[i].rules+' data-type='+result[i].card_type+'></div>')
          }
          $('#moneyText').text('Money: '+moves['money']);
        }
      })

      moves['actions']--;
      console.log(moves, 'after')
      $('#buyText').text('Buys: '+moves['buys'])
      $('#moneyText').text('Money: '+moves['money'])
      $('#actText').text('Actions: '+moves['actions'])
    }
    if(moves['actions']===0){
      endAct();
    }
  });

  $('.board_cards').click(function(){
    if(buyPhase&&moves['buys']>0&&parseInt($(this).data('cost'))<=moves['money']){
      amount_text = $(this).next()
      $.ajax({
        url: '/buy',
        data: {'id':$('#boardData').data('player'),'card_id':$(this)[0].alt},
        success: function(result){
          amount_text.text(parseInt(result))
          alert('You bought a card.');
        }
      })
      moves['buys']--;
      moves['money'] -= parseInt($(this).data('cost'))
      $('#buyText').text('Buys: '+moves['buys'])
      $('#moneyText').text('Money: '+moves['money'])
    }
    if(moves['buys']===0||moves['money']===0){
      //click form submit
    }
  });

  $('#endAct').click(function(){
      endAct();
  });
});
