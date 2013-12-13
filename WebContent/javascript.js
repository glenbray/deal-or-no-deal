
//Submit when player has selected a case
function submit(bCase)
{
	var h = document.getElementById('selectedCase');
	h.value = bCase;
	document.forms["dealNoDeal"].submit();
}

//Submit if player chooses deal or no deal
function deal(isDeal)
{
	var h = document.getElementById('deal');
	
	if(isDeal)
		h.value = 'deal';
	else
		h.value = 'noDeal';
	
	document.forms["endRound"].submit();
}

//Check if back was clicked
function backButton()
{
	var e=document.getElementById("refreshed");
	if(e.value=="no"){e.value="yes";}
	else{e.value="no";location.reload();
	}
	
}