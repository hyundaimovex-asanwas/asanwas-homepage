
	var sub_tree = 9;
	//�޴� �߰��� ����

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
						if (num==1) Image1.src="/english/img/company/menu01_on.gif";
						else if (num==2) Image2.src="/english/img/company/menu02_on.gif";
						else if (num==3) Image3.src="/english/img/company/menu03_on.gif";
						else if (num==4) Image4.src="/english/img/company/menu04_on.gif";
						else if (num==5) Image5.src="/english/img/company/menu05_on.gif";
						else if (num==6) Image5.src="/english/img/company/menu06_on.gif";
						else if (num==7) Image5.src="/english/img/company/menu07_on.gif";
						else if (num==8) Image5.src="/english/img/company/menu08_on.gif";
						else if (num==9) Image5.src="/english/img/company/menu09_on.gif";
						//�޴� �߰��� ����

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
			if (num==1) Image1.src="/english/img/company/menu01_on.gif";
			if (num==2) Image2.src="/english/img/company/menu02_on.gif";
			if (num==3) Image3.src="/english/img/company/menu03_on.gif";
			if (num==4) Image4.src="/english/img/company/menu04_on.gif";
			if (num==5) Image5.src="/english/img/company/menu05_on.gif";
			if (num==6) Image6.src="/english/img/company/menu06_on.gif";
			if (num==7) Image7.src="/english/img/company/menu07_on.gif";
			if (num==8) Image8.src="/english/img/company/menu08_on.gif";
			if (num==9) Image9.src="/english/img/company/menu09_on.gif";
			//�޴� �߰��� ����
		}
	}

