<!--
*****************************************************
* @source       : eisd010.jsp
* @description : ����� ��ȸ PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/11      �̽¿�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
//************************************************************** ezgen
String a1 = "";
String b1 = "";
//************************************************************** ezgen
%>



<html>
<head>
<title>����� ��ȸ(eisd010)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!-- //<script language="javascript" src="/common/calendar/lunarCalendar.js"></script> -->

<SCRIPT ID=clientHnwActivEvent LANGUAGE=javascript FOR="rptObject" EVENT="FireEvent(nParam1,nParam2,strParam)">
<!-- //EZgen�� FireEvent ��ư ����� �߻��� -->
        if (nParam1 > 0) {
            dayCalcDisplay(nParam1,nParam2,strParam);
        } else {
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
		}
</SCRIPT>

<script language="javascript">

   function fnc_OnLoadProcess() {

            frame = window.external.GetFrame(window);

            if (frame.FrameID == "heqa050") {
               document.getElementById("title1").innerText = "������α������ȸ"
               document.getElementById("title2").innerText = "������α������ȸ"
               document.getElementById("dir").innerText = "HOME/�濵����/�����������/"
            }
            else {document.getElementById("title1").innerText = "�������ȸ"
                  document.getElementById("title2").innerText = "�������ȸ"
                  document.getElementById("dir").innerText = "HOME/�ο���Ȳ/"
            }
   }

</script>


<script type="text/javascript">
var lunarMonthTable = [
[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],   /* 1901 */
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2],   /* 1911 */
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],   /* 1921 */
[2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],
[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
[1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
[2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],   /* 1931 */
[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2],
[1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
[2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1],   /* 1941 */
[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
[1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
[2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],   /* 1951 */
[1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
[2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2],
[1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
[2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],   /* 1961 */
[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
[1, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2],   /* 1971 */
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1],
[2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1],
[2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],   /* 1981 */
[2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
[2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],   /* 1991 */
[1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
[1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2],
[1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
[2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2],   /* 2001 */
[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1],
[2, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
[2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],   /* 2011 */
[2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
[2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],   /* 2021 */
[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
[1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
[1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2],
[1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
[2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1],   /* 2031 */
[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 5, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 4, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
[2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],   /* 2041 */
[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]];

function myDate(year, month, day, leapMonth)
{
    this.year = year;
    this.month = month;
    this.day = day;
    this.leapMonth = leapMonth;
}

function lunarCalc(year, month, day, type, leapmonth)
{
    var solYear, solMonth, solDay;
    var lunYear, lunMonth, lunDay;
    var lunLeapMonth, lunMonthDay;
    var i, lunIndex;

    var solMonthDay = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    /* range check */
    if (year < 1900 || year > 2040)
    {
        alert('1900����� 2040������� �����մϴ�');
        return;
    }

    /* �ӵ� ������ ���� ���� ���ڸ� �������� �Ѵ� */
    if (year >= 2000)
    {
        /* �������� ��� 2000�� 1�� 1�� (���� 1999�� 11�� 25��) */
        solYear = 2000;
        solMonth = 1;
        solDay = 1;
        lunYear = 1999;
        lunMonth = 11;
        lunDay = 25;
        lunLeapMonth = 0;

        solMonthDay[1] = 29;    /* 2000 �� 2�� 28�� */
        lunMonthDay = 30;   /* 1999�� 11�� */
    }
    else if (year >= 1970)
    {
        /* �������� ��� 1970�� 1�� 1�� (���� 1969�� 11�� 24��) */
        solYear = 1970;
        solMonth = 1;
        solDay = 1;
        lunYear = 1969;
        lunMonth = 11;
        lunDay = 24;
        lunLeapMonth = 0;

        solMonthDay[1] = 28;    /* 1970 �� 2�� 28�� */
        lunMonthDay = 30;   /* 1969�� 11�� */
    }
    else if (year >= 1940)
    {
        /* �������� ��� 1940�� 1�� 1�� (���� 1939�� 11�� 22��) */
        solYear = 1940;
        solMonth = 1;
        solDay = 1;
        lunYear = 1939;
        lunMonth = 11;
        lunDay = 22;
        lunLeapMonth = 0;

        solMonthDay[1] = 29;    /* 1940 �� 2�� 28�� */
        lunMonthDay = 29;   /* 1939�� 11�� */
    }
    else
    {
        /* �������� ��� 1900�� 1�� 1�� (���� 1899�� 12�� 1��) */
        solYear = 1900;
        solMonth = 1;
        solDay = 1;
        lunYear = 1899;
        lunMonth = 12;
        lunDay = 1;
        lunLeapMonth = 0;

        solMonthDay[1] = 28;    /* 1900 �� 2�� 28�� */
        lunMonthDay = 30;   /* 1899�� 12�� */
    }

    lunIndex = lunYear - 1899;

    while (true)
    {

        if (type == 1 &&
            year == solYear &&
            month == solMonth &&
            day == solDay)
        {
            return new myDate(lunYear, lunMonth, lunDay, lunLeapMonth);
        }
        else if (type == 2 &&
                year == lunYear &&
                month == lunMonth &&
                day == lunDay &&
                leapmonth == lunLeapMonth)
        {
            return new myDate(solYear, solMonth, solDay, 0);
        }

        /* add a day of solar calendar */
        if (solMonth == 12 && solDay == 31)
        {
            solYear++;
            solMonth = 1;
            solDay = 1;

            /* set monthDay of Feb */
            if (solYear % 400 == 0)
                solMonthDay[1] = 29;
            else if (solYear % 100 == 0)
                solMonthDay[1] = 28;
            else if (solYear % 4 == 0)
                solMonthDay[1] = 29;
            else
                solMonthDay[1] = 28;

        }
        else if (solMonthDay[solMonth - 1] == solDay)
        {
            solMonth++;
            solDay = 1;
        }
        else
            solDay++;

        /* add a day of lunar calendar */
        if (lunMonth == 12 &&
            ((lunarMonthTable[lunIndex][lunMonth - 1] == 1 && lunDay == 29) ||
            (lunarMonthTable[lunIndex][lunMonth - 1] == 2 && lunDay == 30)))
        {
            lunYear++;
            lunMonth = 1;
            lunDay = 1;

            if (lunYear > 2043) {
                alert("�Է��Ͻ� ���� �����ϴ�.");
                break;
            }

            lunIndex = lunYear - 1899;

            if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
                lunMonthDay = 30;
        }
        else if (lunDay == lunMonthDay)
        {
            if (lunarMonthTable[lunIndex][lunMonth - 1] >= 3
                && lunLeapMonth == 0)
            {
                lunDay = 1;
                lunLeapMonth = 1;
            }
            else
            {
                lunMonth++;
                lunDay = 1;
                lunLeapMonth = 0;
            }

            if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 3)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 0)
                lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 1)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 0)
                lunMonthDay = 30;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 1)
                    lunMonthDay = 29;
            else if (lunarMonthTable[lunIndex][lunMonth - 1] == 6)
                lunMonthDay = 30;
        }
        else
            lunDay++;
    }
}

function dayCalcDisplay(startYear,startMonth,startDay)
{
    if ( !startYear || startYear == 0 ||
         !startMonth || startMonth == 0 ||
         !startDay || startDay == 0 )
    {
        alert('��¥�� �Է����ּ���');
        return;
    }

    var solMonthDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (startYear % 400 == 0 || ( startYear % 4 == 0 && startYear % 100 != 0 )) solMonthDay[1] += 1;


    if ( startMonth < 1 || startMonth > 12 ||
         startDay < 1 || startDay > solMonthDay[startMonth-1] ) {
        if ( solMonthDay[1] == 28 && startMonth == 2 && startDay > 28 )
            alert("������ �ƴմϴ�. �ٽ� �Է����ּ���");
        else
            alert("��¥ ������ ������ϴ�. �ٽ� �Է����ּ���");
        return;
    }

    var startDate = new Date(startYear, startMonth - 1, startDay);

    /* ���/���� ��ȯ */
    var date = lunarCalc(startYear, startMonth, startDay, 1);

    /*
	return date.year + "�� " +
           (date.leapMonth ? "��" : "") + date.month + "�� " +
           date.day + "�� ";
    */
    form1.rptObject.SetValues = "[:YYYY]=" + date.year + "[:MM]=" + date.month + "[:DD]=" + date.day;
    return
}
</script>





</head>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll="auto" onload="fnc_OnLoadProcess();">
	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><span id="title1"></span></td>
					<td align="right" class="navigator"><span id="dir"></span><font color="#000000"><span id="title2"></span></font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

        <comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="eisd010.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
        </comment>
		<script> __ShowEmbedObject(__NSID__); </script>
	</form>


</body>
</html>
