
	var sub_tree = 7;
	//메뉴 추가시 증가

	function view(num, sub)
	{		
		if(sub==0) {
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
						if (num==1) Image1.src="/english/img/tourist/menu01_on.gif";
						else if (num==2) Image2.src="/english/img/tourist/menu02_on.gif";
						else if (num==3) Image3.src="/english/img/tourist/menu03_on.gif";
						else if (num==4) Image4.src="/english/img/tourist/menu04_on.gif";
						else if (num==5) Image5.src="/english/img/tourist/menu05_on.gif";
						else if (num==6) Image6.src="/english/img/tourist/menu06_on.gif";
						else if (num==7) Image7.src="/english/img/tourist/menu07_on.gif";
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
			if (num==1) {
				Image1.src="/english/img/tourist/menu01_on.gif";		
				if (sub == 1){
					Image11.src="/english/img/tourist/menu0101_on.gif";
				}else if (sub == 2){
					Image12.src="/english/img/tourist/menu0102_on.gif";
				}else if (sub == 3){
					Image13.src="/english/img/tourist/menu0103_on.gif";
				}

			}else if (num==2) {
				Image2.src="/english/img/tourist/menu02_on.gif";	
				if (sub == 1){
					Image21.src="/english/img/tourist/menu0201_on.gif";
				}

			}else if (num==3) {
				Image3.src="/english/img/tourist/menu03_on.gif";	
				if (sub == 1){
					Image31.src="/english/img/tourist/menu0301_on.gif";
				}

			}else if (num==4) {
				Image4.src="/english/img/tourist/menu04_on.gif";	
				if (sub == 1){
					Image41.src="/english/img/tourist/menu0401_on.gif";
				}else if (sub == 2){
					Image42.src="/english/img/tourist/menu0402_on.gif";
				}else if (sub == 3){
					Image43.src="/english/img/tourist/menu0403_on.gif";
				}

			
			}
			//메뉴 추가시 증가
		}
	}

