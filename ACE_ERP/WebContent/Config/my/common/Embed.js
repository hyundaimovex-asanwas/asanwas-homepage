var loca;
loca = document.location;

function __ws__(id){
document.write(id.text);id.id='';
}
var title = "== ��å�Ӱ� �Բ��ϴ� ����������ȣ �����ϱ� =="
var width_num = 1024
var height_num = 680

function prevpage() {
	var page = document.location.href;
	var nowFile = page.indexOf(".htm"); // �ش繮���� ��ġ�� ��ȯ	
	var chCode = page.substring(nowFile-4, nowFile-2);
	var nowCode = page.substring(nowFile-2, nowFile);
	var chaseCode =parseInt(chCode,10)
	if (chaseCode < 10)
	{
		chaseCode = "0"+chaseCode;
	}
	chaseCode = chaseCode
	var prevCode =parseInt(nowCode,10) - 1;
	if (prevCode < 10)
	{
		prevCode = "0"+prevCode;
	}
	moveframe(String(chaseCode)+String(prevCode));
}
//����������
function nextpage() {
	var page = document.location.href;
	var nowFile = page.indexOf(".htm"); // �ش繮���� ��ġ�� ��ȯ
	var chCode = page.substring(nowFile-4, nowFile-2);
	var nowCode = page.substring(nowFile-2, nowFile);
    var chaseCode =parseInt(chCode,10)
	if (chaseCode < 10)
	{
		chaseCode = "0"+chaseCode;
	}
	chaseCode = chaseCode
	var nextCode =parseInt(nowCode,10) + 1;
	if (nextCode < 10)
	{
		nextCode = "0"+nextCode;
	}
    moveframe(String(chaseCode)+String(nextCode));
}
//��ü ������ ����
function totalPage(num){
   endpage = num
}

//������ �̵�
function moveframe(movecode) {
    var movecode;
	//alert(movecode);
	var thispage = movecode.substr(2,3)
	//returnFile = movecode+".htm";
	//document.location.href = returnFile;
	//alert(endpage);	
    /*if (thispage > endpage){
		alert("�̹� ������ ������ ������ �Դϴ�.");
	}else*/ if (thispage < 1){
		alert("�̹� ������ ù ������ �Դϴ�.");
	}else{		
		returnFile = movecode+".htm";
		document.location.href = returnFile;
	}
}