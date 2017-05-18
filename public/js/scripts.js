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
  for(i=0;i<boardArr.length;i++){
    $('#boardRow').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+boardArr[i].image+'" alt="'+boardArr[i].id+'" data-cost='+boardArr[i].cost+'><br><p id="card_amount">'+boardArr[i].amount+' left</p></div>')
  }
  for(i=0;i<handArr.length;i++){
    moves['money']+=handArr[i]['money_value']
    $('#handDiv').append('<div class="col-md-2 cardDiv" id="handCard'+i+'"><img class="card hand_cards" src="'+handArr[i].image+'" alt="'+handArr[i].deck_id+'" data-rules='+handArr[i].rules+' data-type='+handArr[i].card_type+'></div>')
  }
  $('#moneyText').text('Money: '+moves['money']);

  $('body').on('click', 'img.hand_cards', function(){
    if(actionPhase && moves['actions']>0 && $(this).data('type')=='action'){
      $.ajax({
        url: '/discard',
        data: {'deck_id':this.alt},
        success: function() {
        }
      })
      rules=$(this).data('rules').toString();
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
          console.log(result[result.length-1])
          $('#deckCount').text(result[result.length-1]['deck'])
          for(i=0;i<result.length-1;i++){
            moves['money']+=result[i]['money_value']
            $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card hand_cards" src="'+result[i].image+'" alt="'+result[i].deck_id+'" data-rules='+result[i].rules+' data-type='+result[i].card_type+'></div>')
          }
          $('#moneyText').text('Money: '+moves['money']);
        }
      })

      moves['actions']--;
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
      amount_text = $(this).next().next()
      img = $(this)
      $.ajax({
        url: '/buy',
        data: {'id':$('#boardData').data('player'),'card_id':$(this)[0].alt},
        success: function(result){
          result = result.substr(1,result.length-2)
          result_arr = []
          result.split(',').forEach(function(c){
            c.replace(/"/g, "");
            result_arr.push(c.replace(/"/g, ""));
          })
          console.log(result_arr)
          if(result_arr[result_arr.length-1]=='true'){
            $('#endTurn').hide();
            actionPhase = false;
            buyPhase = false;
            if(result_arr.length>=3){
              answer = ''
              for(i=0; i<result_arr.length-1; i++){
                if(i==result_arr.length-2){
                  answer += ' and '+result_arr[i];
                }
                else{
                  answer += result_arr[i]+', '
                }
              }
              $('#game-over').prepend('<h1>Tie! The winners are '+answer+'!</h1>')
            }
            else{
              $('#game-over').prepend('<h1>The winner is '+result_arr[0]+'!</h1>')
            }
            $("#game-over").dialog("open");
            $('.ui-dialog-titlebar-close').remove();
          }
          else{
            amount_text.text(parseInt(result_arr[0])+' left')
            $('#dialog').empty();
            $('#dialog').append('<h2>You bought </h2><br><img src="'+img[0].src+'">')
            $("#dialog").dialog("open");
            $('.ui-dialog-titlebar-close').remove();
            setTimeout(function(){
              $('#dialog').dialog('close');
            }, 2000);
            $('#victoryText').text('Victory Points: '+result_arr[1]);
          }
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

  $("#dialog").dialog({
  autoOpen: false,
  height: 650,
  width: 500,
  draggable: true,
  resizable: false,
  closeOnEscape: false
  });
  $("#game-over").dialog({
  autoOpen: false,
  height: 250,
  width: 450,
  draggable: true,
  resizable: false,
  closeOnEscape: false
  });

  $('#endAct').click(function(){
      endAct();
  });
});
