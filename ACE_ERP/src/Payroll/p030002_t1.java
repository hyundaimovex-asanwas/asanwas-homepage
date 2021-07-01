package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030002_t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int  idxYYYY			= userSet.indexOfColumn("APPDT");
				int  idxEMPNO			= userSet.indexOfColumn("EMPNO");
				int  idxBA0101YN	= userSet.indexOfColumn("BA0101YN");
				int  idxBA0102CNT = userSet.indexOfColumn("BA0102CNT");
				int  idxBA0103CNT = userSet.indexOfColumn("BA0103CNT");
				int  idxBA0104CNT = userSet.indexOfColumn("BA0104CNT");
				int  idxBA0105CNT = userSet.indexOfColumn("BA0105CNT");
				int  idxAD0101CNT = userSet.indexOfColumn("AD0101CNT");
				int  idxAD0102CNT = userSet.indexOfColumn("AD0102CNT");
				int  idxAD0103CNT = userSet.indexOfColumn("AD0103CNT");
				int  idxAD0104YN	= userSet.indexOfColumn("AD0104YN");
				int  idxAD0105CNT = userSet.indexOfColumn("AD0105CNT");
				int  idxPENSUM		= userSet.indexOfColumn("PENSUM");
				int  idxINSAMT01	= userSet.indexOfColumn("INSAMT01");
				int  idxINSAMT02	= userSet.indexOfColumn("INSAMT02");
				int  idxINSAMT03	= userSet.indexOfColumn("INSAMT03");
				int  idxINSAMT04	= userSet.indexOfColumn("INSAMT04");
				int  idxMEDAMT01	= userSet.indexOfColumn("MEDAMT01");
				int  idxMEDAMT02	= userSet.indexOfColumn("MEDAMT02");
				int  idxEDUAMT01	= userSet.indexOfColumn("EDUAMT01");
				int  idxEDUAMT02	= userSet.indexOfColumn("EDUAMT02");
				int  idxEDUAMT021 = userSet.indexOfColumn("EDUAMT021");
				int  idxEDUAMT022 = userSet.indexOfColumn("EDUAMT022");
				int  idxEDUAMT023 = userSet.indexOfColumn("EDUAMT023");
				int  idxEDUAMT024 = userSet.indexOfColumn("EDUAMT024");
				int  idxEDUAMT025 = userSet.indexOfColumn("EDUAMT025");
				int  idxEDUAMT03	= userSet.indexOfColumn("EDUAMT03");
				int  idxEDUAMT031 = userSet.indexOfColumn("EDUAMT031");
				int  idxEDUAMT032 = userSet.indexOfColumn("EDUAMT032");
				int  idxEDUAMT033 = userSet.indexOfColumn("EDUAMT033");
				int  idxEDUAMT034 = userSet.indexOfColumn("EDUAMT034");
				int  idxEDUAMT035 = userSet.indexOfColumn("EDUAMT035");
				int  idxEDUAMT04	= userSet.indexOfColumn("EDUAMT04");
				int  idxEDUAMT041 = userSet.indexOfColumn("EDUAMT041");
				int  idxEDUAMT042 = userSet.indexOfColumn("EDUAMT042");
				int  idxEDUAMT043 = userSet.indexOfColumn("EDUAMT043");
				int  idxEDUAMT044 = userSet.indexOfColumn("EDUAMT044");
				int  idxEDUAMT045 = userSet.indexOfColumn("EDUAMT045");
				int  idxEDUAMT05	= userSet.indexOfColumn("EDUAMT05");
				int  idxEDUAMT051 = userSet.indexOfColumn("EDUAMT051");
				int  idxEDUAMT052 = userSet.indexOfColumn("EDUAMT052");
				int  idxEDUAMT053 = userSet.indexOfColumn("EDUAMT053");
				int  idxEDUAMT054 = userSet.indexOfColumn("EDUAMT054");
				int  idxEDUAMT055 = userSet.indexOfColumn("EDUAMT055");
				int  idxHOUAMT01	= userSet.indexOfColumn("HOUAMT01");
				int  idxHOUAMT02	= userSet.indexOfColumn("HOUAMT02");
				int  idxHOUAMT03	= userSet.indexOfColumn("HOUAMT03");
				int  idxHOUAMT04	= userSet.indexOfColumn("HOUAMT04");
				int  idxCONAMT01	= userSet.indexOfColumn("CONAMT01");
				int  idxCONAMT02	= userSet.indexOfColumn("CONAMT02");
				int  idxCONAMT03	= userSet.indexOfColumn("CONAMT03");
				int  idxCONAMT04	= userSet.indexOfColumn("CONAMT04");
				int  idxCONAMT05	= userSet.indexOfColumn("CONAMT05");
				int  idxCONAMT06	= userSet.indexOfColumn("CONAMT06");
				int  idxMARCNT01	= userSet.indexOfColumn("MARCNT01");
				int  idxMARCNT02	= userSet.indexOfColumn("MARCNT02");
				int  idxMARCNT03	= userSet.indexOfColumn("MARCNT03");
				int  idxETCAMT011 = userSet.indexOfColumn("ETCAMT011");
				int  idxETCAMT01	= userSet.indexOfColumn("ETCAMT01");
				int  idxETCAMT02	= userSet.indexOfColumn("ETCAMT02");
				int  idxETCAMT031	= userSet.indexOfColumn("ETCAMT031");
				int  idxETCAMT032 = userSet.indexOfColumn("ETCAMT032");
				int  idxETCAMT033 = userSet.indexOfColumn("ETCAMT033");
				int  idxETCAMT034 = userSet.indexOfColumn("ETCAMT034");
				int  idxETCAMT04	= userSet.indexOfColumn("ETCAMT04");
				int  idxREDAMT01	= userSet.indexOfColumn("REDAMT01");
				int  idxREDAMT02	= userSet.indexOfColumn("REDAMT02");
				int  idxDEDAMT01	= userSet.indexOfColumn("DEDAMT01");
				int  idxDEDAMT02	= userSet.indexOfColumn("DEDAMT02");
				int  idxDEDAMT03	= userSet.indexOfColumn("DEDAMT03");
				int  idxDEDAMT04	= userSet.indexOfColumn("DEDAMT04");
				int  idxDEDAMT05	= userSet.indexOfColumn("DEDAMT05");
				int  idxPB61000		=	userSet.indexOfColumn("PB61000");
	
				int  idxRELAT1  = userSet.indexOfColumn("RELAT1");
				int  idxFAMNM1  = userSet.indexOfColumn("FAMNM1");
				int  idxRESINO1 = userSet.indexOfColumn("RESINO1");
				int  idxRELAT2  = userSet.indexOfColumn("RELAT2");
				int  idxFAMNM2  = userSet.indexOfColumn("FAMNM2");
				int  idxRESINO2 = userSet.indexOfColumn("RESINO2");
				int  idxRELAT3  = userSet.indexOfColumn("RELAT3");
				int  idxFAMNM3  = userSet.indexOfColumn("FAMNM3");
				int  idxRESINO3 = userSet.indexOfColumn("RESINO3");
				int  idxRELAT4  = userSet.indexOfColumn("RELAT4");
				int  idxFAMNM4  = userSet.indexOfColumn("FAMNM4");
				int  idxRESINO4 = userSet.indexOfColumn("RESINO4");
				int  idxRELAT5  = userSet.indexOfColumn("RELAT5");
				int  idxFAMNM5  = userSet.indexOfColumn("FAMNM5");
				int  idxRESINO5 = userSet.indexOfColumn("RESINO5");
				int  idxRELAT6  = userSet.indexOfColumn("RELAT6");
				int  idxFAMNM6  = userSet.indexOfColumn("FAMNM6");
				int  idxRESINO6 = userSet.indexOfColumn("RESINO6");
				int  idxRELAT7  = userSet.indexOfColumn("RELAT7");
				int  idxFAMNM7  = userSet.indexOfColumn("FAMNM7");
				int  idxRESINO7 = userSet.indexOfColumn("RESINO7");
				int  idxRELAT8  = userSet.indexOfColumn("RELAT8");
				int  idxFAMNM8  = userSet.indexOfColumn("FAMNM8");
				int  idxRESINO8 = userSet.indexOfColumn("RESINO8");
				int  idxRELAT9  = userSet.indexOfColumn("RELAT9");
				int  idxFAMNM9  = userSet.indexOfColumn("FAMNM9");
				int  idxRESINO9 = userSet.indexOfColumn("RESINO9");
				
				int  idxREF11 = userSet.indexOfColumn("REF11");
				int  idxREF21 = userSet.indexOfColumn("REF21");
				int  idxREF31 = userSet.indexOfColumn("REF31");
				int  idxREF41 = userSet.indexOfColumn("REF41");
				int  idxREF51 = userSet.indexOfColumn("REF51");
				int  idxREF61 = userSet.indexOfColumn("REF61");
				int  idxREF71 = userSet.indexOfColumn("REF71");
				int  idxREF81 = userSet.indexOfColumn("REF81");
				int  idxREF91 = userSet.indexOfColumn("REF91");

				int  idxREF12 = userSet.indexOfColumn("REF12");
				int  idxREF22 = userSet.indexOfColumn("REF22");
				int  idxREF32 = userSet.indexOfColumn("REF32");
				int  idxREF42 = userSet.indexOfColumn("REF42");
				int  idxREF52 = userSet.indexOfColumn("REF52");
				int  idxREF62 = userSet.indexOfColumn("REF62");
				int  idxREF72 = userSet.indexOfColumn("REF72");
				int  idxREF82 = userSet.indexOfColumn("REF82");
				int  idxREF92 = userSet.indexOfColumn("REF92");

				int  idxREF13 = userSet.indexOfColumn("REF13");
				int  idxREF23 = userSet.indexOfColumn("REF23");
				int  idxREF33 = userSet.indexOfColumn("REF33");
				int  idxREF43 = userSet.indexOfColumn("REF43");
				int  idxREF53 = userSet.indexOfColumn("REF53");
				int  idxREF63 = userSet.indexOfColumn("REF63");
				int  idxREF73 = userSet.indexOfColumn("REF73");
				int  idxREF83 = userSet.indexOfColumn("REF83");
				int  idxREF93 = userSet.indexOfColumn("REF93");

				int  idxREF14 = userSet.indexOfColumn("REF14");
				int  idxREF24 = userSet.indexOfColumn("REF24");
				int  idxREF34 = userSet.indexOfColumn("REF34");
				int  idxREF44 = userSet.indexOfColumn("REF44");
				int  idxREF54 = userSet.indexOfColumn("REF54");
				int  idxREF64 = userSet.indexOfColumn("REF64");
				int  idxREF74 = userSet.indexOfColumn("REF74");
				int  idxREF84 = userSet.indexOfColumn("REF84");
				int  idxREF94 = userSet.indexOfColumn("REF94");

				int  idxREF15 = userSet.indexOfColumn("REF15");
				int  idxREF25 = userSet.indexOfColumn("REF25");
				int  idxREF35 = userSet.indexOfColumn("REF35");
				int  idxREF45 = userSet.indexOfColumn("REF45");
				int  idxREF55 = userSet.indexOfColumn("REF55");
				int  idxREF65 = userSet.indexOfColumn("REF65");
				int  idxREF75 = userSet.indexOfColumn("REF75");
				int  idxREF85 = userSet.indexOfColumn("REF85");
				int  idxREF95 = userSet.indexOfColumn("REF95");

				int  idxREF16 = userSet.indexOfColumn("REF16");
				int  idxREF26 = userSet.indexOfColumn("REF26");
				int  idxREF36 = userSet.indexOfColumn("REF36");
				int  idxREF46 = userSet.indexOfColumn("REF46");
				int  idxREF56 = userSet.indexOfColumn("REF56");
				int  idxREF66 = userSet.indexOfColumn("REF66");
				int  idxREF76 = userSet.indexOfColumn("REF76");
				int  idxREF86 = userSet.indexOfColumn("REF86");
				int  idxREF96 = userSet.indexOfColumn("REF96");

				int  idxREF17 = userSet.indexOfColumn("REF17");
				int  idxREF27 = userSet.indexOfColumn("REF27");
				int  idxREF37 = userSet.indexOfColumn("REF37");
				int  idxREF47 = userSet.indexOfColumn("REF47");
				int  idxREF57 = userSet.indexOfColumn("REF57");
				int  idxREF67 = userSet.indexOfColumn("REF67");
				int  idxREF77 = userSet.indexOfColumn("REF77");
				int  idxREF87 = userSet.indexOfColumn("REF87");
				int  idxREF97 = userSet.indexOfColumn("REF97");

				int  idxREF18 = userSet.indexOfColumn("REF18");
				int  idxREF28 = userSet.indexOfColumn("REF28");
				int  idxREF38 = userSet.indexOfColumn("REF38");
				int  idxREF48 = userSet.indexOfColumn("REF48");
				int  idxREF58 = userSet.indexOfColumn("REF58");
				int  idxREF68 = userSet.indexOfColumn("REF68");
				int  idxREF78 = userSet.indexOfColumn("REF78");
				int  idxREF88 = userSet.indexOfColumn("REF88");
				int  idxREF98 = userSet.indexOfColumn("REF98");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();																						
				InsertSql.append( "  " );		
			
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.YCPAYCOL SET ");
				UpdateSql.append( " BA0101YN=?,		BA0102CNT=?,	BA0103CNT=?,	BA0104CNT=?,	BA0105CNT=?,	");
        UpdateSql.append( " AD0101CNT=?,	AD0102CNT=?,	AD0103CNT=?,	AD0104YN=?,		AD0105CNT=?,	");
				UpdateSql.append( " PENSUM=?,			INSAMT01=?,		INSAMT02=?,		INSAMT03=?,		INSAMT04=?,		");
				UpdateSql.append( " MEDAMT01=?,		MEDAMT02=?,		EDUAMT01=?,		EDUAMT02=?,		EDUAMT021=?,	");
				UpdateSql.append( " EDUAMT022=?,	EDUAMT023=?,	EDUAMT024=?,	EDUAMT025=?,	EDUAMT03=?,		");
				UpdateSql.append( " EDUAMT031=?,	EDUAMT032=?,	EDUAMT033=?,	EDUAMT034=?,	EDUAMT035=?,	");
				UpdateSql.append( " EDUAMT04=?,		EDUAMT041=?,	EDUAMT042=?,	EDUAMT043=?,	EDUAMT044=?,	");
				UpdateSql.append( " EDUAMT045=?,	EDUAMT05=?,		EDUAMT051=?,	EDUAMT052=?,	EDUAMT053=?,	");
				UpdateSql.append( " EDUAMT054=?,	EDUAMT055=?,	HOUAMT01=?,		HOUAMT02=?,		HOUAMT03=?,		");
				UpdateSql.append( " HOUAMT04=?,		CONAMT01=?,		CONAMT02=?,		CONAMT03=?,		CONAMT04=?,		");
				UpdateSql.append( " CONAMT05=?,		CONAMT06=?,		MARCNT01=?,		MARCNT02=?,		MARCNT03=?,		");
				UpdateSql.append( " ETCAMT011=?,	ETCAMT01=?,		ETCAMT02=?,		ETCAMT031=?,	ETCAMT032=?,	");
				UpdateSql.append( " ETCAMT033=?,	ETCAMT034=?,	ETCAMT04=?,		REDAMT01=?,		REDAMT02=?,		");
				UpdateSql.append( " DEDAMT01=?,		DEDAMT02=?,		DEDAMT03=?,		DEDAMT04=?,		DEDAMT05=?,		");
				UpdateSql.append( " PB61000=?, ");
				UpdateSql.append( " RELAT1  = ?,  FAMNM1  = ?, RESINO1 = ?, RELAT2  = ?, FAMNM2  = ?, ");
				UpdateSql.append( " RESINO2 = ?,  RELAT3  = ?, FAMNM3  = ?, RESINO3 = ?, RELAT4  = ?, ");
				UpdateSql.append( " FAMNM4  = ?,  RESINO4 = ?, RELAT5  = ?, FAMNM5  = ?, RESINO5 = ?, ");
				UpdateSql.append( " RELAT6  = ?,  FAMNM6  = ?, RESINO6 = ?, RELAT7  = ?, FAMNM7  = ?, ");
				UpdateSql.append( " RESINO7 = ?,  RELAT8  = ?, FAMNM8  = ?, RESINO8 = ?, RELAT9  = ?, ");
				UpdateSql.append( " FAMNM9  = ?,  RESINO9 = ?, ");
				UpdateSql.append( " REF11 = ?, REF21 = ?, REF31 = ?, REF41 = ?, REF51 = ?, REF61 = ?, REF71 = ?, REF81 = ?, REF91 = ?, ");
				UpdateSql.append( " REF12 = ?, REF22 = ?, REF32 = ?, REF42 = ?, REF52 = ?, REF62 = ?, REF72 = ?, REF82 = ?, REF92 = ?, ");
				UpdateSql.append( " REF13 = ?, REF23 = ?, REF33 = ?, REF43 = ?, REF53 = ?, REF63 = ?, REF73 = ?, REF83 = ?, REF93 = ?, ");
				UpdateSql.append( " REF14 = ?, REF24 = ?, REF34 = ?, REF44 = ?, REF54 = ?, REF64 = ?, REF74 = ?, REF84 = ?, REF94 = ?, ");
				UpdateSql.append( " REF15 = ?, REF25 = ?, REF35 = ?, REF45 = ?, REF55 = ?, REF65 = ?, REF75 = ?, REF85 = ?, REF95 = ?, ");
				UpdateSql.append( " REF16 = ?, REF26 = ?, REF36 = ?, REF46 = ?, REF56 = ?, REF66 = ?, REF76 = ?, REF86 = ?, REF96 = ?, ");
				UpdateSql.append( " REF17 = ?, REF27 = ?, REF37 = ?, REF47 = ?, REF57 = ?, REF67 = ?, REF77 = ?, REF87 = ?, REF97 = ?, ");
				UpdateSql.append( " REF18 = ?, REF28 = ?, REF38 = ?, REF48 = ?, REF58 = ?, REF68 = ?, REF78 = ?, REF88 = ?, REF98 = ?  ");
			  UpdateSql.append( " WHERE APPDT = ?	AND EMPNO = ?	AND PAYDIV = 'Y' ");
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE from  PAYROLL.YCPAYCOL ");
			  DeleteSql.append( " WHERE  APPDT = ? AND  EMPNO = ? AND  PAYDIV = 'Y' ");

			for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					  GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
            gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxBA0101YN);
						gsmt.bindColumn(2,idxBA0102CNT);
						gsmt.bindColumn(3,idxBA0103CNT);
						gsmt.bindColumn(4,idxBA0104CNT);
						gsmt.bindColumn(5,idxBA0105CNT);
						gsmt.bindColumn(6,idxAD0101CNT);
						gsmt.bindColumn(7,idxAD0102CNT);
						gsmt.bindColumn(8,idxAD0103CNT);
						gsmt.bindColumn(9,idxAD0104YN);
						gsmt.bindColumn(10,idxAD0105CNT);
						gsmt.bindColumn(11,idxPENSUM);
						gsmt.bindColumn(12,idxINSAMT01);
						gsmt.bindColumn(13,idxINSAMT02);
						gsmt.bindColumn(14,idxINSAMT03);
						gsmt.bindColumn(15,idxINSAMT04);
						gsmt.bindColumn(16,idxMEDAMT01);
						gsmt.bindColumn(17,idxMEDAMT02);
						gsmt.bindColumn(18,idxEDUAMT01);
						gsmt.bindColumn(19,idxEDUAMT02);
						gsmt.bindColumn(20,idxEDUAMT021);
						gsmt.bindColumn(21,idxEDUAMT022);
						gsmt.bindColumn(22,idxEDUAMT023);
						gsmt.bindColumn(23,idxEDUAMT024);
						gsmt.bindColumn(24,idxEDUAMT025);
						gsmt.bindColumn(25,idxEDUAMT03);
						gsmt.bindColumn(26,idxEDUAMT031);
						gsmt.bindColumn(27,idxEDUAMT032);
						gsmt.bindColumn(28,idxEDUAMT033);
						gsmt.bindColumn(29,idxEDUAMT034);
						gsmt.bindColumn(30,idxEDUAMT035);
						gsmt.bindColumn(31,idxEDUAMT04);
						gsmt.bindColumn(32,idxEDUAMT041);
						gsmt.bindColumn(33,idxEDUAMT042);
						gsmt.bindColumn(34,idxEDUAMT043);
						gsmt.bindColumn(35,idxEDUAMT044);
						gsmt.bindColumn(36,idxEDUAMT045);
						gsmt.bindColumn(37,idxEDUAMT05);
						gsmt.bindColumn(38,idxEDUAMT051);
						gsmt.bindColumn(39,idxEDUAMT052);
						gsmt.bindColumn(40,idxEDUAMT053);
						gsmt.bindColumn(41,idxEDUAMT054);
						gsmt.bindColumn(42,idxEDUAMT055);
						gsmt.bindColumn(43,idxHOUAMT01);
						gsmt.bindColumn(44,idxHOUAMT02);
						gsmt.bindColumn(45,idxHOUAMT03);
						gsmt.bindColumn(46,idxHOUAMT04);
						gsmt.bindColumn(47,idxCONAMT01);
						gsmt.bindColumn(48,idxCONAMT02);
						gsmt.bindColumn(49,idxCONAMT03);
						gsmt.bindColumn(50,idxCONAMT04);
						gsmt.bindColumn(51,idxCONAMT05);
						gsmt.bindColumn(52,idxCONAMT06);
						gsmt.bindColumn(53,idxMARCNT01);
						gsmt.bindColumn(54,idxMARCNT02);
						gsmt.bindColumn(55,idxMARCNT03);
						gsmt.bindColumn(56,idxETCAMT011);
						gsmt.bindColumn(57,idxETCAMT01);
						gsmt.bindColumn(58,idxETCAMT02);
						gsmt.bindColumn(59,idxETCAMT031);
						gsmt.bindColumn(60,idxETCAMT032);
						gsmt.bindColumn(61,idxETCAMT033);
						gsmt.bindColumn(62,idxETCAMT034);
						gsmt.bindColumn(63,idxETCAMT04);
						gsmt.bindColumn(64,idxREDAMT01);
						gsmt.bindColumn(65,idxREDAMT02);
						gsmt.bindColumn(66,idxDEDAMT01);
						gsmt.bindColumn(67,idxDEDAMT02);
						gsmt.bindColumn(68,idxDEDAMT03);
						gsmt.bindColumn(69,idxDEDAMT04);
						gsmt.bindColumn(70,idxDEDAMT05);
						gsmt.bindColumn(71,idxPB61000);

						gsmt.bindColumn(72, idxRELAT1);
						gsmt.bindColumn(73, idxFAMNM1);
						gsmt.bindColumn(74, idxRESINO1);
						gsmt.bindColumn(75, idxRELAT2);
						gsmt.bindColumn(76, idxFAMNM2);
						gsmt.bindColumn(77, idxRESINO2);
						gsmt.bindColumn(78, idxRELAT3);
						gsmt.bindColumn(79, idxFAMNM3);
						gsmt.bindColumn(80, idxRESINO3);
						gsmt.bindColumn(81, idxRELAT4);
						gsmt.bindColumn(82, idxFAMNM4);
						gsmt.bindColumn(83, idxRESINO4);
						gsmt.bindColumn(84, idxRELAT5);
						gsmt.bindColumn(85, idxFAMNM5);
						gsmt.bindColumn(86, idxRESINO5);
						gsmt.bindColumn(87, idxRELAT6);
						gsmt.bindColumn(88, idxFAMNM6);
						gsmt.bindColumn(89, idxRESINO6);
						gsmt.bindColumn(90, idxRELAT7);
						gsmt.bindColumn(91, idxFAMNM7);
						gsmt.bindColumn(92, idxRESINO7);
						gsmt.bindColumn(93, idxRELAT8);
						gsmt.bindColumn(94, idxFAMNM8);
						gsmt.bindColumn(95, idxRESINO8);
						gsmt.bindColumn(96, idxRELAT9);
						gsmt.bindColumn(97, idxFAMNM9);
						gsmt.bindColumn(98, idxRESINO9);
						gsmt.bindColumn(99, idxREF11);
						gsmt.bindColumn(100,idxREF21);
						gsmt.bindColumn(101,idxREF31);
						gsmt.bindColumn(102,idxREF41);
						gsmt.bindColumn(103,idxREF51);
						gsmt.bindColumn(104,idxREF61);
						gsmt.bindColumn(105,idxREF71);
						gsmt.bindColumn(106,idxREF81);
						gsmt.bindColumn(107,idxREF91);
						gsmt.bindColumn(108,idxREF12);
						gsmt.bindColumn(109,idxREF22);
						gsmt.bindColumn(110,idxREF32);
						gsmt.bindColumn(111,idxREF42);
						gsmt.bindColumn(112,idxREF52);
						gsmt.bindColumn(113,idxREF62);
						gsmt.bindColumn(114,idxREF72);
						gsmt.bindColumn(115,idxREF82);
						gsmt.bindColumn(116,idxREF92);
						gsmt.bindColumn(117,idxREF13);
						gsmt.bindColumn(118,idxREF23);
						gsmt.bindColumn(119,idxREF33);
						gsmt.bindColumn(120,idxREF43);
						gsmt.bindColumn(121,idxREF53);
						gsmt.bindColumn(122,idxREF63);
						gsmt.bindColumn(123,idxREF73);
						gsmt.bindColumn(124,idxREF83);
						gsmt.bindColumn(125,idxREF93);
						gsmt.bindColumn(126,idxREF14);
						gsmt.bindColumn(127,idxREF24);
						gsmt.bindColumn(128,idxREF34);
						gsmt.bindColumn(129,idxREF44);
						gsmt.bindColumn(130,idxREF54);
						gsmt.bindColumn(131,idxREF64);
						gsmt.bindColumn(132,idxREF74);
						gsmt.bindColumn(133,idxREF84);
						gsmt.bindColumn(134,idxREF94);
						gsmt.bindColumn(135,idxREF15);
						gsmt.bindColumn(136,idxREF25);
						gsmt.bindColumn(137,idxREF35);
						gsmt.bindColumn(138,idxREF45);
						gsmt.bindColumn(139,idxREF55);
						gsmt.bindColumn(140,idxREF65);
						gsmt.bindColumn(141,idxREF75);
						gsmt.bindColumn(142,idxREF85);
						gsmt.bindColumn(143,idxREF95);
						gsmt.bindColumn(144,idxREF16);
						gsmt.bindColumn(145,idxREF26);
						gsmt.bindColumn(146,idxREF36);
						gsmt.bindColumn(147,idxREF46);
						gsmt.bindColumn(148,idxREF56);
						gsmt.bindColumn(149,idxREF66);
						gsmt.bindColumn(150,idxREF76);
						gsmt.bindColumn(151,idxREF86);
						gsmt.bindColumn(152,idxREF96);
						gsmt.bindColumn(153,idxREF17);
						gsmt.bindColumn(154,idxREF27);
						gsmt.bindColumn(155,idxREF37);
						gsmt.bindColumn(156,idxREF47);
						gsmt.bindColumn(157,idxREF57);
						gsmt.bindColumn(158,idxREF67);
						gsmt.bindColumn(159,idxREF77);
						gsmt.bindColumn(160,idxREF87);
						gsmt.bindColumn(161,idxREF97);
						gsmt.bindColumn(162,idxREF18);
						gsmt.bindColumn(163,idxREF28);
						gsmt.bindColumn(164,idxREF38);
						gsmt.bindColumn(165,idxREF48);
						gsmt.bindColumn(166,idxREF58);
						gsmt.bindColumn(167,idxREF68);
						gsmt.bindColumn(168,idxREF78);
						gsmt.bindColumn(169,idxREF88);
						gsmt.bindColumn(170,idxREF98);
						gsmt.bindColumn(171,idxYYYY);
						gsmt.bindColumn(172,idxEMPNO);
						gsmt.executeUpdate(); 
						gsmt.close();       
					}      
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}

/*
			GauceDataSet user2Set = req.getGauceDataSet("USER2");
			if (user2Set != null) {
				if (req.isBuilderRequest()) {
					user2Set.setUsage(true);
					user2Set.addDataColumn(new GauceDataColumn("deptno", GauceDataColumn.TB_INT));
					user2Set.addDataColumn(new GauceDataColumn("dname", GauceDataColumn.TB_STRING));
					user2Set.addDataColumn(new GauceDataColumn("loc", GauceDataColumn.TB_STRING));
					res.write(user2Set);
				}

				int idxDeptno = user2Set.indexOfColumn("deptno");
				int idxDname = user2Set.indexOfColumn("dname");
				int idxLoc = user2Set.indexOfColumn("loc");
				GauceDataRow[] rows = user2Set.getDataRows();
				for (int j = 0; j < rows.length; j++) {
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								String query = "insert into dept(deptno, dname, loc) values(?, ?, ?)";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.bindColumn(2, idxDname);
								gsmt.bindColumn(3, idxLoc);
								gsmt.executeUpdate();
								gsmt.close();
						}
						if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
								String query = "update dept set deptno =?, dname = ?, loc = ? where deptno = ?";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.bindColumn(2, idxDname);
								gsmt.bindColumn(3, idxLoc);
								gsmt.bindColumn(4, idxDeptno);
								gsmt.executeUpdate();
								gsmt.close();
						}
						if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
								String query = "delete from dept where deptno = ?";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.executeUpdate();
								gsmt.close();
						}
				}
			}
*/

			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}