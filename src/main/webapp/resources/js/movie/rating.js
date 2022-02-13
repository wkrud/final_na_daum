/* 별점 */
const drawStar = (target) => {
	document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
	
	if(document.querySelector(`.star span`).style.width == '10%'){
		$("#section-rating #rating-3").text("0.5");
		$("#section-rating #rating-result").val("0.5");
	} else if(document.querySelector(`.star span`).style.width == '20%'){
		$("#section-rating #rating-3").text("1.0");
		$("#section-rating #rating-result").val("1.0");
	} else if(document.querySelector(`.star span`).style.width == '30%'){
		$("#section-rating #rating-3").text("1.5");
		$("#section-rating #rating-result").val("1.5");
	} else if(document.querySelector(`.star span`).style.width == '40%'){
		$("#section-rating #rating-3").text("2.0");
		$("#section-rating #rating-result").val("2.0");
	} else if(document.querySelector(`.star span`).style.width == '50%'){
		$("#section-rating #rating-3").text("2.5");
		$("#section-rating #rating-result").val("2.5");
	} else if(document.querySelector(`.star span`).style.width == '60%'){
		$("#section-rating #rating-3").text("3.0");
		$("#section-rating #rating-result").val("3.0");
	} else if(document.querySelector(`.star span`).style.width == '70%'){
		$("#section-rating #rating-3").text("3.5");
		$("#section-rating #rating-result").val("3.5");
	} else if(document.querySelector(`.star span`).style.width == '80%'){
		$("#section-rating #rating-3").text("4.0");
		$("#section-rating #rating-result").val("4.0");
	} else if(document.querySelector(`.star span`).style.width == '90%'){
		$("#section-rating #rating-3").text("4.5");
		$("#section-rating #rating-result").val("4.5");
	} else if(document.querySelector(`.star span`).style.width == '100%'){
		$("#section-rating #rating-3").text("5.0");
		$("#section-rating #rating-result").val("5.0");
	}
}