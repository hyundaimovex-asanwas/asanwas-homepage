
	var sub_tree = 9;
	//메뉴 추가시 증가

	function view(num)
	{		
		if(num==0) {
			for (i=1; i<=sub_tree; i++)
			{
				menu=eval("document.all.block"+i+".style");
				if (num==i)
				{
					if (menu.display == "block")
					{	
						menu.display="none";
					}
					else
					{
						if (num==1) Image1.src="/english/img/kaesong/menu01_on.gif";
						else if (num==2) Image2.src="/english/img/kaesong/menu02_on.gif";
						else if (num==3) Image3.src="/english/img/kaesong/menu03_on.gif";
						else if (num==4) Image4.src="/english/img/kaesong/menu04_on.gif";
						else if (num==5) Image5.src="/english/img/kaesong/menu05_on.gif";
						else if (num==6) Image5.src="/english/img/kaesong/menu06_on.gif";
						else if (num==7) Image5.src="/english/img/kaesong/menu07_on.gif";
						else if (num==8) Image5.src="/english/img/kaesong/menu08_on.gif";
						else if (num==9) Image5.src="/english/img/kaesong/menu09_on.gif";
						//메뉴 추가시 증가

						menu.display="block";
					}
				}
				else
				{
					menu.display="none";
				}
			}
		}
		else {
			if (num==1) Image1.src="/english/img/kaesong/menu01_on.gif";
			if (num==2) Image2.src="/english/img/kaesong/menu02_on.gif";
			if (num==3) Image3.src="/english/img/kaesong/menu03_on.gif";
			if (num==4) Image4.src="/english/img/kaesong/menu04_on.gif";
			if (num==5) Image5.src="/english/img/kaesong/menu05_on.gif";
			if (num==6) Image6.src="/english/img/kaesong/menu06_on.gif";
			if (num==7) Image7.src="/english/img/kaesong/menu07_on.gif";
			if (num==8) Image8.src="/english/img/kaesong/menu08_on.gif";
			if (num==9) Image9.src="/english/img/kaesong/menu09_on.gif";
			//메뉴 추가시 증가
		}
	}

