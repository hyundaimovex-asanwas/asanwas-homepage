
		// Calendar �� �θ��� �Լ� ����

		function MM_findObj(n, d) { //v3.0
			var p,i,x;
			if (!d) d=document;
			if ((p=n.indexOf("?"))>0&&parent.frames.length) {
				d=parent.frames[n.substring(p+1)].document;
				n=n.substring(0,p);
			}
			if (!(x=d[n])&&d.all) x=d.all[n];
			for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			for (i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			return x;
		}

		function MM_showHideLayers() { //v3.0
			var i,p,v,obj,args=MM_showHideLayers.arguments;
			for (i=0; i<(args.length-2); i+=3)
				if ((obj=MM_findObj(args[i]))!=null) {
					v=args[i+2];
					if (obj.style) {
						obj=obj.style;
						//v=(v=='show')?'visible':(v=='hide')?'hidden':v;
						v=(v=='show')?'block':(v=='hide')?'none':v;
					}
					//obj.visibility=v;
					obj.display = v;
					obj.zIndex=101;
				}
		}

		function doDown() {
			MM_showHideLayers('ifrmcal','','hide');
		}
		
		
		// datetype : 10�ڸ�����(YYYY-MM-DD), 8�ڸ�(YYYY-MM)����, ��ǥ���� ���� Ÿ������..
		// datename : ������ input name
		function calendarBtn(datetype,datename,datename2,leftval,topval) {

			var inputDate = document.getElementById(datename).value;
			
			if(inputDate.length==4) inputDate += '-01-01';

			if( document.getElementById(datename).value != '' && !cfDateExpr(inputDate) ) {
				alert('��¥���Ŀ� ���� �ʽ��ϴ�.');
				document.getElementById(datename).value = '';
				return;
			}

			if ((obj=MM_findObj('ifrmcal'))!=null) {
				if (obj.style) {
					obj=obj.style;
				}
				if(leftval == undefined || topval == undefined){
					if(event.x - event.offsetX - 80 >= document.body.clientWidth - 190){
						obj.left = document.body.clientWidth - 190;
					}else{
						obj.left = event.x - event.offsetX - 80;
					}
					if(event.y - event.offsetY + 25 >= document.body.clientHeight - 160){
						obj.top = document.body.clientHeight - 160;
					}else{
						obj.top = event.y - event.offsetY + 25;
					}
				}else{
					obj.left=leftval;
					obj.top=topval;
				}
			}
			
			calendarfrm.buttonmenu(datetype,datename,datename2);

			MM_showHideLayers('ifrmcal','','show');

		}
		
		
		document.onmousedown = doDown;

		// Calendar �� �θ��� �Լ� ��

		function show_Calendar() {


			/* ������Ʈ�� SPAN�� ���� �̷��� �ϸ� �ȴ�.
			if (document.all('viewCal').style.visibility == "hidden") {
			document.all('viewCal').style.visibility = "visible";
			}else if (document.all('viewCal').style.visibility== "visible"){
			document.all('viewCal').style.visibility = "hidden";
			}
			*/

			if (document.all('viewCal').style.display == "none") {
			document.all('viewCal').style.display = "";
			}else if (document.all('viewCal').style.display == ""){
			document.all('viewCal').style.display = "none";
			}

			return false;
		}