//?????????? ???? ??????
var middleMenu = "";
var premiddle = "";
var premiddle2 = "";
var premiddle3 = "";
var premiddle4 = "";
var premiddle5 = "";

function set_menu(middle){
   if (middle == "0")
   {
      premiddleMenu = document.getElementById(premiddle);
      middleMenu.innerHTML = premiddleMenu.innerText;
      premiddle = "";
      return;
   }
   if (premiddle != ""){
      premiddleMenu = document.getElementById(premiddle);
      middleMenu.innerHTML = premiddleMenu.innerText;
   }
   middleMenu = document.getElementById(middle);
   middleMenu.innerHTML = "<font color=red>" + middleMenu.innerText + "</font>";
   premiddle = middle;
}

function set_menu2(middle){
   if (premiddle2 == middle){
      premiddleMenu = document.getElementById(premiddle2);
      premiddleMenu.innerHTML = premiddleMenu.innerText;
      premiddle2 = "";
      return;
   }
   if (premiddle3 == middle){
      premiddleMenu = document.getElementById(premiddle3);
      premiddleMenu.innerHTML = premiddleMenu.innerText;
      premiddle3 = "";
      return;
   }
   if (premiddle4 == middle){
      premiddleMenu = document.getElementById(premiddle4);
      premiddleMenu.innerHTML = premiddleMenu.innerText;
      premiddle4 = "";
      return;
   }
   if (premiddle5 == middle){
      premiddleMenu = document.getElementById(premiddle5);
      premiddleMenu.innerHTML = premiddleMenu.innerText;
      premiddle5 = "";
      return;
   }

   if (premiddle2 == "")
   {
      middleMenu = document.getElementById(middle);
      middleMenu.innerHTML = "<font color=red>" + middleMenu.innerText + "</font>";
      premiddle2 = middle;
   }
   else
   {
      if (premiddle3 == "")
      {
         middleMenu = document.getElementById(middle);
         middleMenu.innerHTML = "<font color=red>" + middleMenu.innerText + "</font>";
         premiddle3 = middle;
      }
      else
      {
         if (premiddle4 == "")
         {
            middleMenu = document.getElementById(middle);
            middleMenu.innerHTML = "<font color=red>" + middleMenu.innerText + "</font>";
            premiddle4 = middle;
         }
         else
         {
            if (premiddle5 == "")
            {
               middleMenu = document.getElementById(middle);
               middleMenu.innerHTML = "<font color=red>" + middleMenu.innerText + "</font>";
               premiddle5 = middle;
            }
         }
      }
   }
}
