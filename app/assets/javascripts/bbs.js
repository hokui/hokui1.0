function bbs_onClick(id){
  var bbs_topic_id=eval(id);
  $.ajax({
    type: 'GET',
    url: '/bbs_bodies/create_bbs_window/'+bbs_topic_id,
    dataType: 'script'
  });
  $.ajax({
    type: 'GET',
    url: '/bbs_bodies/return_bbs_data/'+bbs_topic_id+'/1',
    dataType: 'script'
  });
  $('input#bbs-display-button-'+bbs_topic_id).attr("disabled","disabled");
  $('input#bbs-destroy-button-'+bbs_topic_id).removeAttr("disabled");
}

function bbs_destroy(id){
  var bbs_topic_id=eval(id);
  $('div#bbs-wrapper-'+bbs_topic_id).empty();
  $('input#bbs-display-button-'+bbs_topic_id).removeAttr("disabled");
  $('input#bbs-destroy-button-'+bbs_topic_id).attr("disabled","disabled");
}
