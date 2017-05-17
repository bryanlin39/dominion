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
    $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card hand_cards" src="'+handArr[i].image+'" alt="'+handArr[i].deck_id+'" data-rules='+handArr[i].rules+' data-type='+handArr[i].card_type+'></div>')
  }
  $('#moneyText').text('Money: '+moves['money']);

  $('.hand_cards').click(function(){
    if(actionPhase&&moves['actions']>0&&$(this).data('type')=='action'){
      $.ajax({
        url: '/discard',
        data: {'deck_id':this.alt},
      })
      rules=$(this).data('rules');
      moves['actions'] += parseInt(rules[1])
      moves['buys'] += parseInt(rules[2])
      moves['money'] += parseInt(rules[0])
      if(parseInt(rules[3])!=0){
        $('#handDiv').empty();
        $.ajax({
          url: '/draw',
          data: {'id':window.document['URL'][window.document['URL'].length-1],'number_to_draw':parseInt(rules[3])},
          dataType: 'json',
          success: function(result){
            moves['money']=0;
            for(i=0;i<result.length;i++){
              moves['money']+=result[i]['money_value']
              $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+result[i].image+'" alt="'+result[i].id+'"></div>')
            }
            $('#moneyText').text('Money: '+moves['money']);
          }
        })
      }
      moves['actions']--;
      $('#actText').text('Actions: '+moves['actions'])
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
  $('#draw').click(function(){
    $('#handDiv').empty();
    $.ajax({
      url: '/draw',
      data: {'id':window.document['URL'][window.document['URL'].length-1],'number_to_draw':1},
      dataType: 'json',
      success: function(result){
        moves['money']=0;
        for(i=0;i<result.length;i++){
          moves['money']+=result[i]['money_value']
          $('#handDiv').append('<div class="col-md-2 cardDiv"><img class="card board_cards" src="'+result[i].image+'" alt="'+result[i].id+'"></div>')
        }
        $('#moneyText').text('Money: '+moves['money']);
      }
    })
  })
  $('#buy').click(function(){
    $.ajax({
      url: '/buy',
      data: {'id':window.document['URL'][window.document['URL'].length-1],'card_id':1},
      success: function(result){
        alert('You bought'+result+'!')
      }
    })
  })
});
