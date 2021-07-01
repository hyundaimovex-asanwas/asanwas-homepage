package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t5 extends HttpServlet{

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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				long lngPENAMT03=0; //����������+����������

				long[] lngINSAMT = new long[2];  //���强�����/��������뺸���
				long[] lngMEDAMT = new long[2];  //����65�������/�׿�
				
				long lngEDUAMT01 =0;              //����
				long[] lngEDUAMT02 = new long[6];  //������
				long[] lngEDUAMT03 = new long[6];  //���߰�
				long[] lngEDUAMT04 = new long[6];  //����
				long[] lngEDUAMT05 = new long[6];  //����� ������
				long lngEDUSUM=0;
				long lngSAVSUM1234=0; //��������հ� 
				long[] lngHOUAMT = new long[5];  //�����������Ա�/������/�����������14/�����������15/�����������30
				long[] lngCONAMT = new long[7];  //��ġ�ڱݼ��װ�����/����/Ư��/���ι��ν�Ź/�츮����/������/����
				long[] lngPESAMT = new long[2];  //���ο�������/��������
				long[] lngSAVAMT = new long[4];  //û������/�ٷ������ø�������/����û����������/������ø�������
				long[] lngCRDAMT = new long[4];  //�ſ�ī��/����ī��/���ݿ�����/�п����κ񳳺�
				long[] lngFNDAMT = new long[3];  //����ֽ����� 1��/2��/3����

				long lngConChk=0;   //��α�üũ 
        long lngConChk2=0;  //��α�üũ 
				long lngCONAMT67=0; //������ü+������ü��
				long lngCONSUM =0;

        long lngCRDAMT1234 =0; //ī����ü�ݾ� 
				long lngCRDAMT134 =0;  //����ī���ܱ̿ݾ�		              
				long lngCrdChk =0;     //ī��üũ
				long lngCRDSUM =0;     //ī������ݾ�
				long lngFNDSUM =0;     //����ֽ��� �������
				long lngMEDSUM =0;     //�Ƿ��
				long lngHOUSUM =0;     //�����������Ա���

				long lngTOTPAY =0;    //�����հ�
				double dblCardCal=0;    //ī�� �Ҽ��� ���� ���

				//��αݰ����ѵ�
				long lngCONLMT10 =0;    //������αݰ����ѵ�
				long lngCONLMT30 =0;    //Ư�ʱ�αݰ����ѵ�
				long lngCONLMT31 =0;    //���ͱ�αݰ����ѵ�
				long lngCONLMT40 =0;    //�����ܱ�αݰ����ѵ�
				long lngCONLMT41 =0;    //������αݰ����ѵ�


  
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //�ͼӳ⵵       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //�ͼӳ⵵       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //�ʱ�ȭ 
						lngPENAMT03=0;
						lngEDUAMT01=0;
						lngEDUSUM=0;
						lngSAVSUM1234=0;  //��������հ� 
            lngConChk=0;      //��α�üũ               
           	lngConChk2=0;     //��α�üũ              
						lngCONAMT67=0;    //������ü+������ü��     
						lngCONSUM =0;     //��α��հ�                       
						lngCRDAMT1234 =0; //ī����ü�ݾ�         
						lngCRDAMT134 =0;  //����ī���ܱ̿ݾ�		 
						lngCrdChk =0;     //ī��üũ             
						lngCRDSUM =0;     //ī������ݾ�         
						lngFNDSUM =0;     //����ֽ��� �������  
						lngMEDSUM =0;     //�Ƿ��               
						lngHOUSUM =0;     //�����������Ա���     
						lngTOTPAY =0;     //�����հ�
				    dblCardCal=0;     //ī�� �Ҽ��� ���� ���

						lngCONLMT10 =0;    //������αݰ����ѵ�
						lngCONLMT30 =0;    //Ư�ʱ�αݰ����ѵ�
						lngCONLMT31 =0;    //���ͱ�αݰ����ѵ�
						lngCONLMT40 =0;    //�����ܱ�αݰ����ѵ�
						lngCONLMT41 =0;    //������αݰ����ѵ�

						for(int i=0;i<2;i++){
							lngINSAMT[i]=0;
							lngMEDAMT[i]=0;
							lngPESAMT[i]=0;
						}

						for(int i=0;i<3;i++){
							lngFNDAMT[i]=0;
						}

						for(int i=0;i<4;i++){
							lngSAVAMT[i]=0;
							lngCRDAMT[i]=0;
						}

						for(int i=0;i<5;i++){
							lngHOUAMT[i]=0;
						}

            //[0]�� �ο��� �̴�.
						for(int i=0;i<6;i++){
							lngEDUAMT02[i]=0;
							lngEDUAMT03[i]=0;
							lngEDUAMT04[i]=0;
							lngEDUAMT05[i]=0;
							
						}

						for(int i=0;i<7;i++){
							lngCONAMT[i]=0;
						}
         
						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.APPYY,    A.EMPNO,   B.TOTPAY, B.LABPAY,                                          \n" ); 
						SelectSql.append( "        A.INSAMT03, A.INSAMT04,                                                             \n" ); 
						SelectSql.append( "        A.MEDAMT01, A.MEDAMT02,                                                             \n" ); 
						SelectSql.append( "        A.EDUAMT01,                                                                         \n" ); 
            SelectSql.append( "        A.EDUCNT02, A.EDUAMT021, A.EDUAMT022, A.EDUAMT023, A.EDUAMT024, A.EDUAMT025,        \n" ); 
						SelectSql.append( "        A.EDUCNT03, A.EDUAMT031, A.EDUAMT032, A.EDUAMT033, A.EDUAMT034, A.EDUAMT035,        \n" ); 
						SelectSql.append( "        A.EDUCNT04, A.EDUAMT041, A.EDUAMT042, A.EDUAMT043, A.EDUAMT044, A.EDUAMT045,        \n" ); 
						SelectSql.append( "        A.EDUCNT05, A.EDUAMT051, A.EDUAMT052, A.EDUAMT053, A.EDUAMT054, A.EDUAMT055,        \n" ); 
						SelectSql.append( "        A.HOUAMT01, A.HOUAMT02, A.HOUAMT03, A.HOUAMT04, A.HOUAMT05,                         \n" ); 
						SelectSql.append( "        A.CONAMT01, A.CONAMT02, A.CONAMT03, A.CONAMT04, A.CONAMT05, A.CONAMT06, A.CONAMT07, \n" ); 
						SelectSql.append( "        ---------------------------------------------------------------------               \n" ); 
						SelectSql.append( "        (A.PESAMT01+A.YERAMT) AS PESAMT01,  (A.PESAMT02+A.JUCAMT)AS PESAMT02, A.CPENAMT03, A.BPENAMT03, \n" );
						SelectSql.append( "        A.SAVAMT01, A.SAVAMT02, A.SAVAMT03, A.SAVAMT04,                                     \n" ); 
						SelectSql.append( "        A.CRDAMT01, A.CRDAMT02, A.CRDAMT03, A.CRDAMT04,                                     \n" ); 
						SelectSql.append( "        A.FNDAMT01, A.FNDAMT02, A.FNDAMT03                                                  \n" );
						//SelectSql.append( "   FROM PAYROLL.YCENTRY10_2 A, PAYROLL.YCPAY10 B                                            \n" ); 
						SelectSql.append( "   FROM PAYROLL.YCENTRY10 A, PAYROLL.YCPAY10 B                                              \n" ); 
						SelectSql.append( "  WHERE A.APPYY='"+rows[j].getString(idxAPPYY)+"'														             	   \n" ); 
						SelectSql.append( "    AND A.EMPNO ='"+rows[j].getString(idxEMPNO)+"'															               \n" ); 
            SelectSql.append( "    AND A.APPYY = B.APPYY														               \n" ); 
						SelectSql.append( "    AND A.EMPNO = B.EMPNO														               \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							//logger.dbg.println(this,"step1");


               //��������
              lngPENAMT03 = rs.getLong("CPENAMT03")+rs.getLong("BPENAMT03");
							if(lngPENAMT03>3000000) lngPENAMT03=3000000;

              //���强���� 
							if(rs.getInt("INSAMT03")>=1000000){
								lngINSAMT[0]=1000000;
							}else{
                lngINSAMT[0]=rs.getInt("INSAMT03");
							}

							//��������뺸��
              if(rs.getInt("INSAMT04")>=1000000){
								lngINSAMT[1]=1000000;
							}else{
                lngINSAMT[1]=rs.getInt("INSAMT04");
							}

							//�Ƿ�� ==> �ѱ޿����� �ʿ���.
							lngMEDAMT[0] = rs.getLong("MEDAMT01");                             //����65�������
              lngMEDAMT[1] = rs.getLong("MEDAMT02")- rs.getLong("TOTPAY")*3/100;  //�׿� �߰�����
              if(lngMEDAMT[1]>=7000000){
                lngMEDAMT[1]=7000000;
							}
              lngMEDSUM=lngMEDAMT[0]+lngMEDAMT[1];
							if(lngMEDSUM<0){
								lngMEDSUM=0;
							}

						
							//������//////////////////////////////////////////////////////////////////
							lngEDUAMT01=rs.getLong("EDUAMT01"); //����(����)
              lngEDUAMT02[1]=rs.getLong("EDUAMT021"); //������(300��)
							lngEDUAMT02[2]=rs.getLong("EDUAMT022"); //������(300��)
							lngEDUAMT02[3]=rs.getLong("EDUAMT023"); //������(300��)
							lngEDUAMT02[4]=rs.getLong("EDUAMT024"); //������(300��)
							lngEDUAMT02[5]=rs.getLong("EDUAMT025"); //������(300��)
							lngEDUAMT03[1]=rs.getLong("EDUAMT031"); //���߰�(300��))
							lngEDUAMT03[2]=rs.getLong("EDUAMT032"); //���߰�(300��))
							lngEDUAMT03[3]=rs.getLong("EDUAMT033"); //���߰�(300��))
							lngEDUAMT03[4]=rs.getLong("EDUAMT034"); //���߰�(300��))
							lngEDUAMT03[5]=rs.getLong("EDUAMT035"); //���߰�(300��))
							lngEDUAMT04[1]=rs.getLong("EDUAMT041"); //����(900��)
							lngEDUAMT04[2]=rs.getLong("EDUAMT042"); //����(900��)
							lngEDUAMT04[3]=rs.getLong("EDUAMT043"); //����(900��)
							lngEDUAMT04[4]=rs.getLong("EDUAMT044"); //����(900��)
							lngEDUAMT04[5]=rs.getLong("EDUAMT045"); //����(900��)
							lngEDUAMT05[1]=rs.getLong("EDUAMT051"); //���(����)
							lngEDUAMT05[2]=rs.getLong("EDUAMT052"); //���(����)
							lngEDUAMT05[3]=rs.getLong("EDUAMT053"); //���(����)
							lngEDUAMT05[4]=rs.getLong("EDUAMT054"); //���(����)
							lngEDUAMT05[5]=rs.getLong("EDUAMT055"); //���(����)
							
							if(rs.getLong("EDUAMT021")>3000000) lngEDUAMT02[1]=3000000; //������(300��)
							if(rs.getLong("EDUAMT022")>3000000) lngEDUAMT02[2]=3000000; //������(300��)
							if(rs.getLong("EDUAMT023")>3000000) lngEDUAMT02[3]=3000000; //������(300��)
							if(rs.getLong("EDUAMT024")>3000000) lngEDUAMT02[4]=3000000; //������(300��)
							if(rs.getLong("EDUAMT025")>3000000) lngEDUAMT02[5]=3000000; //������(300��)

							if(rs.getLong("EDUAMT031")>3000000) lngEDUAMT03[1]=3000000; //���߰�(300��) 
							if(rs.getLong("EDUAMT032")>3000000) lngEDUAMT03[2]=3000000; //���߰�(300��) 
							if(rs.getLong("EDUAMT033")>3000000) lngEDUAMT03[3]=3000000; //���߰�(300��) 
							if(rs.getLong("EDUAMT034")>3000000) lngEDUAMT03[4]=3000000; //���߰�(300��) 
							if(rs.getLong("EDUAMT035")>3000000) lngEDUAMT03[5]=3000000; //���߰�(300��) 

							if(rs.getLong("EDUAMT041")>9000000) lngEDUAMT04[1]=9000000; //����(900��) 
							if(rs.getLong("EDUAMT042")>9000000) lngEDUAMT04[2]=9000000; //����(900��) 
							if(rs.getLong("EDUAMT043")>9000000) lngEDUAMT04[3]=9000000; //����(900��) 
							if(rs.getLong("EDUAMT044")>9000000) lngEDUAMT04[4]=9000000; //����(900��) 
							if(rs.getLong("EDUAMT045")>9000000) lngEDUAMT04[5]=9000000; //����(900��) 

							lngEDUSUM=lngEDUAMT01;

              for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT02[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT03[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT04[i];
							}

							for(int i=1;i<6;i++){
								lngEDUSUM+=lngEDUAMT05[i];
							}
							

							//logger.dbg.println(this,"step2");


             /////////////////////////////////////////////////////////////////////////

              //���ø�������(1)
							//û������
							//����û����������
							//������ø�������

							//�����������Ա�(2)
							//���������� 40%
              //������     40%

							//��������������Ա�(3)
							//(1)+(2)       �ѵ� 300����
							//(3)��         �ѵ� 600 / 1000 / 1500
							//(1)+(2)+(3)�� �ѵ� 600 / 1000 / 1500

							//���ҵ��� 8800�������ϸ� ����

             
         			//���ø������� �ѵ�300����///////////////////////////////////////////////
              lngSAVAMT[0] =rs.getLong("SAVAMT01")*4/10 ; //û������                100
							lngSAVAMT[1] =rs.getLong("SAVAMT02")*4/10 ; //�ٷ������ø�������      70 
							lngSAVAMT[2] =rs.getLong("SAVAMT03")*4/10 ; //����û����������        50
							lngSAVAMT[3] =rs.getLong("SAVAMT04")*4/10 ; //������ø�������        200

              //������ø�������:�ѱ޿� 8õ8�����ϸ� ����
							if(rs.getLong("TOTPAY")>88000000){
								lngSAVAMT[3]=0;
							}

							//logger.dbg.println(this,"step3");
              
							lngSAVSUM1234 = lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2]+lngSAVAMT[3]; //

              //���� 300���� �̻��� ��� �ܾ� ��� 
              if(lngSAVSUM1234>3000000){
								lngSAVSUM1234=3000000;	
							}

							if(lngSAVAMT[0]>3000000){
								lngSAVAMT[0]=3000000;
                lngSAVAMT[1]=0;
								lngSAVAMT[2]=0;
								lngSAVAMT[3]=0;
							}else if((lngSAVAMT[0]+lngSAVAMT[1])>3000000){
								lngSAVAMT[1]=lngSAVSUM1234-lngSAVAMT[0];
								lngSAVAMT[2]=0;
								lngSAVAMT[3]=0;
							}else if((lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2])>3000000){
								lngSAVAMT[2]=lngSAVSUM1234-lngSAVAMT[0]-lngSAVAMT[1];
								lngSAVAMT[3]=0;
							}else{
								lngSAVAMT[3]=lngSAVSUM1234-lngSAVAMT[0]-lngSAVAMT[1]-lngSAVAMT[2];
							}
               ///////////////////////////////////////////////////////////////////////           			            
              
              //�����������Աݰ���
              lngHOUAMT[0] = rs.getLong("HOUAMT01")*4/10; //�����������Ա�
              lngHOUAMT[1] = rs.getLong("HOUAMT02")*4/10; //������

							//logger.dbg.println(this,"step4");
							
							//���� 300���� �̻��� ��� �ܾ� ��� 
							//�����������Ա�
              if(lngHOUAMT[0]>0){
								lngHOUAMT[0] = lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[0]>3000000){
									lngHOUAMT[0]=3000000;
								}
								lngHOUAMT[0] = lngHOUAMT[0]-lngSAVSUM1234;
							}
     
              //������
              if(lngHOUAMT[1]>0){
								lngHOUAMT[1] = lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[1]>3000000){
									lngHOUAMT[1]=3000000;
								}
								lngHOUAMT[1] = lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							} 

							//�����������Ա� 600&1000&1500������ ���ÿ� ���ٴ� �����Ͽ��� ����.

      				//�����������Ա� 600����
              lngHOUAMT[2] = rs.getLong("HOUAMT03");

							if(lngHOUAMT[2]>0){
								lngHOUAMT[2]=lngHOUAMT[2]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[2]>6000000){
									lngHOUAMT[2]=6000000;
								}
								lngHOUAMT[2]=lngHOUAMT[2]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}
               
              //�����������Ա� 1000����
              lngHOUAMT[3] = rs.getLong("HOUAMT04");
              
							if(lngHOUAMT[3]>0){
								lngHOUAMT[3]=lngHOUAMT[3]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[3]>10000000){
									lngHOUAMT[3]=10000000;  
								}
								lngHOUAMT[3]=lngHOUAMT[3]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}

							//�����������Ա� 1500����
              lngHOUAMT[4] = rs.getLong("HOUAMT05");
              if(lngHOUAMT[4]>0){
								lngHOUAMT[4]=lngHOUAMT[4]+lngHOUAMT[1]+lngHOUAMT[0]+lngSAVSUM1234;
								if(lngHOUAMT[4]>15000000){
									lngHOUAMT[4]=15000000;  
								}
								lngHOUAMT[4]=lngHOUAMT[4]-lngHOUAMT[1]-lngHOUAMT[0]-lngSAVSUM1234;
							}	

							lngHOUSUM = lngHOUAMT[2] + lngHOUAMT[3] + lngHOUAMT[4];

              //��αݰ���//////////////////////////////////////////////////////////////////              
							lngCONAMT[0] = rs.getLong("CONAMT01");  //��ġ       100
							lngCONAMT[1] = rs.getLong("CONAMT02");  //����       100  
							lngCONAMT[2] = rs.getLong("CONAMT03");  //Ư��        50
							lngCONAMT[3] = rs.getLong("CONAMT04");  //����        50
							lngCONAMT[4] = rs.getLong("CONAMT05");  //�츮����    30
							lngCONAMT[5] = rs.getLong("CONAMT06");  //������ü��  20
							lngCONAMT[6] = rs.getLong("CONAMT07");  //������ü    10

							lngConChk = rs.getLong("LABPAY");        //�ٷμҵ�ݾ�

							//logger.dbg.println(this,"step5");
					    
							//��ġ
							if(lngCONAMT[0]>lngConChk){
								lngCONAMT[0] = lngConChk;
							}

              //����
							lngConChk = rs.getLong("LABPAY")-lngCONAMT[0];
							lngCONLMT10 = lngConChk;
              if(lngCONAMT[1]>lngConChk){
								lngCONAMT[1] = lngConChk;
							}

              //Ư��
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1])*5/10;
              lngCONLMT30=lngConChk;
							if(lngCONAMT[2]>lngConChk){
								lngCONAMT[2] = lngConChk;
							}
              //logger.dbg.println(this,"step55");
              //���� 
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2])*5/10;
              lngCONLMT31=lngConChk;
							if(lngCONAMT[3]>lngConChk){
								lngCONAMT[3] = lngConChk;
							}

							//�츮����
							lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3])*3/10;
							if(lngCONAMT[4]>lngConChk){
								lngCONAMT[4] = lngConChk;
							}

							//logger.dbg.println(this,"step555");

							//������ü�� �ִ� ��� 
							if(lngCONAMT[6]>0){
								lngConChk  = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*1/10;
								lngConChk2 = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*1/10;

								if(lngCONAMT[5]>lngConChk2){
										lngConChk = lngConChk+lngConChk2;
								}else{
										lngConChk = lngConChk+lngCONAMT[5];
								}
								

                
								if(lngCONAMT[5]>0){ //������ ��ü�� �ִ� ���   (���� & ������ �Ѵ� ����)       
                  lngCONLMT40 = 0;
									lngCONLMT41 = lngConChk;								
								}else{              //������ ��ü�� ���� ���   (������ü�� ����)  
								  lngCONLMT40 = 0;
                  lngCONLMT41 = lngConChk;
								}
							}

							//logger.dbg.println(this,"step5555");

							//������ü�� ���� ��� 
							if(lngCONAMT[6]==0){
								lngConChk = (rs.getLong("LABPAY")-lngCONAMT[0]-lngCONAMT[1]-lngCONAMT[2]-lngCONAMT[3]-lngCONAMT[4])*2/10;							
								lngCONLMT40 =lngConChk;
								lngCONLMT41 =0;
							}

							lngCONAMT67 = lngCONAMT[5]+lngCONAMT[6];

							if(lngCONAMT67>lngConChk){
								lngCONAMT67=lngConChk;
							}

							lngCONSUM = lngCONAMT[0]+lngCONAMT[1]+lngCONAMT[2]+lngCONAMT[3]+lngCONAMT[4]+lngCONAMT67;
              							
              //logger.dbg.println(this,"step55555");
							//���ο������� �ҵ���� 
							lngPESAMT[0] = rs.getLong("PESAMT01")*4/10;


							if(lngPESAMT[0]>720000){
								lngPESAMT[0]=720000;
							}
									
							//��������ҵ���� ( ��������+��������<=300����)
              //ȸ�翬�����൵ �߰��ؾ���....2011.02.01.JYS
							//PAYROLL.YCENTRY10��  HPESAMT02 �� �ϰ������ؾ���.

							lngPESAMT[1]=rs.getLong("PESAMT02")+rs.getLong("CPENAMT03")+rs.getLong("BPENAMT03");
							if(lngPESAMT[1]>3000000){
								lngPESAMT[1]=3000000;
							}

							//logger.dbg.println(this,"step555555");

							//�ſ�ī��� �ҵ����
							lngCRDAMT[0]=rs.getLong("CRDAMT01"); //�ſ�ī��
							lngCRDAMT[1]=rs.getLong("CRDAMT02"); //����ī��
							lngCRDAMT[2]=rs.getLong("CRDAMT03"); //���ݿ�����
							lngCRDAMT[3]=rs.getLong("CRDAMT04"); //�п����κ񳳺�

							//����ݾ� (��) �ſ�ī��+���ݿ�����+�п����κ񳳺�
							//����ݾ� (��) ����ī��

							//�ſ�ī�� ���ݾ� 
							lngCRDAMT1234 = lngCRDAMT[0]+lngCRDAMT[1]+lngCRDAMT[2]+lngCRDAMT[3];
							lngCRDAMT134  = lngCRDAMT[0]+lngCRDAMT[2]+lngCRDAMT[3];
              lngTOTPAY = rs.getLong("TOTPAY");

//							logger.dbg.prlngln(this,"lngCRDAMT1234:::"+lngCRDAMT1234);
//							logger.dbg.prlngln(this,"lngCRDAMT134:::"+lngCRDAMT134);
//							logger.dbg.prlngln(this,"lngTOTPAY:::"+lngTOTPAY);


              //lngTOTPAY =(lngTOTPAY*25);
//						  logger.dbg.prlngln(this,"11lngTOTPAY:::"+lngTOTPAY);
							
							//lngTOTPAY = lngTOTPAY/100;

							if(lngCRDAMT1234>0){
								lngTOTPAY = (lngTOTPAY*25)/100; //�ѱ޿��� 25%

								//logger.dbg.println(this,"22lngTOTPAY:::"+lngTOTPAY);
								lngCrdChk =(lngCRDAMT1234-lngTOTPAY);


								//logger.dbg.println(this,"lngCRDAMT1234:::"+lngCRDAMT1234);
								//logger.dbg.println(this,"lngCrdChk:::"+lngCrdChk);

								//logger.dbg.println(this,"lngCRDAMT134:::"+lngCRDAMT134);
								//logger.dbg.println(this,"lngCRDAMT[1]:::"+lngCRDAMT[1]);

								dblCardCal =(double)((lngCRDAMT134*0.2+lngCRDAMT[1]*0.25)/lngCRDAMT1234);

								//logger.dbg.println(this,"dblCardCal:::"+dblCardCal);



								if(lngCrdChk<=0){
									lngCrdChk=0;
								}else{
									 lngCrdChk= (long)(lngCrdChk*dblCardCal);								       
								}

								//logger.dbg.println(this,"step6");
							 
								if(lngCrdChk>(rs.getLong("TOTPAY")*20)/100){
									lngCrdChk=(rs.getLong("TOTPAY")*20)/100;
								}

								//logger.dbg.println(this,"step7::"+lngCrdChk);

								//logger.dbg.println(this,"xxxx:::"+(rs.getLong("TOTPAY")*20)/100);

								if(lngCrdChk>3000000){
									lngCRDSUM=3000000;
								}else{
									lngCRDSUM=lngCrdChk;
								}
							}

							//����ֽ������� �ҵ����
							lngFNDAMT[0]=rs.getLong("FNDAMT01");
							lngFNDAMT[1]=rs.getLong("FNDAMT02");
							lngFNDAMT[2]=rs.getLong("FNDAMT03");
							
							if(lngFNDAMT[0]>0) lngFNDAMT[0] =lngFNDAMT[0]*20/100;
							if(lngFNDAMT[1]>0) lngFNDAMT[1] =lngFNDAMT[1]*10/100;
							if(lngFNDAMT[2]>0) lngFNDAMT[2] =lngFNDAMT[2]*5/100;


							//logger.dbg.println(this,"step8");

							lngFNDSUM=lngFNDAMT[0]+lngFNDAMT[1]+lngFNDAMT[2]; 

						  /////////////////////////////////////////////////////////////////////////////////////////////
							//0 ���޸��� UPDATE 
						  /////////////////////////////////////////////////////////////////////////////////////////////
							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET  \n");   						
							UpdateSql.append( "  PENAMT03 = "+lngPENAMT03+" \n");   // ����������+���������� ����.
							UpdateSql.append( " ,INSAMT03 = "+lngINSAMT[0]+" \n");  //���强�����
							UpdateSql.append( " ,INSAMT04 = "+lngINSAMT[1]+" \n");  //����κ���� 
							UpdateSql.append( " ,MEDSUM   = "+lngMEDSUM+"    \n");  //�Ƿ��
							UpdateSql.append( " ,EDUSUM   = "+lngEDUSUM+"    \n");  //������
							UpdateSql.append( " ,HOUAMT01 = "+lngHOUAMT[0]+" \n");  //�����������Ա�
							UpdateSql.append( " ,HOUAMT02 = "+lngHOUAMT[1]+" \n");  //������
							UpdateSql.append( " ,HOUAMT03 = "+lngHOUSUM+"    \n");  //�����������Ա�
							UpdateSql.append( " ,CONAMT   = "+lngCONSUM+"    \n");  //��α�
							UpdateSql.append( " ,PESAMT01 = "+lngPESAMT[0]+" \n");  //���ο�������
							UpdateSql.append( " ,PESAMT02 = "+lngPESAMT[1]+" \n");  //��������
							UpdateSql.append( " ,SAVAMT01 = "+lngSAVAMT[0]+" \n");  //û������
							UpdateSql.append( " ,SAVAMT02 = "+lngSAVAMT[1]+" \n");  //�ٷ������ø�������
							UpdateSql.append( " ,SAVAMT03 = "+lngSAVAMT[2]+" \n");  //����û����������
							UpdateSql.append( " ,SAVAMT04 = "+lngSAVAMT[3]+" \n");  //������ø�������
							UpdateSql.append( " ,CRDSUM   = "+lngCRDSUM+"    \n");  //�ſ�ī���
							UpdateSql.append( " ,FNDSUM   = "+lngFNDSUM+"    \n");  //����ֽ�������
							UpdateSql.append( " ,CONLMT10 = "+lngCONLMT10+"  \n");  //
							UpdateSql.append( " ,CONLMT30 = "+lngCONLMT30+"  \n");  //
							UpdateSql.append( " ,CONLMT31 = "+lngCONLMT31+"  \n");  //
							UpdateSql.append( " ,CONLMT40 = "+lngCONLMT40+"  \n");  //
							UpdateSql.append( " ,CONLMT41 = "+lngCONLMT41+"  \n");  //
							//������հ� 
              UpdateSql.append( " ,BNTAX1SUM = BNTAX101+BNTAX102+BNTAX103+BNTAX104+BNTAX105  \n");  //
							UpdateSql.append( " ,BNTAX2SUM = BNTAX201+BNTAX202+BNTAX203+BNTAX204+BNTAX205  \n");  //
              UpdateSql.append( " ,BNTAX3SUM = BNTAX301+BNTAX302+BNTAX303+BNTAX304+BNTAX305  \n");  //

							UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							//logger.dbg.println(this,"step16");
												
 					  }//while	
						stmt.close();
						rs.close();

				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
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