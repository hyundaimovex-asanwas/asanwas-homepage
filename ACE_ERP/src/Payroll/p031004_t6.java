package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t6 extends HttpServlet{

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

			  long lngChkSum = 0; //�ѵ� üũ�ݾ� 
				long lngCCP41000=0; //�����ҵ漼
				long lngCCP42000=0; //��������ҵ漼
				long lngCCP43000=0; //������Ư��
				long lngCCP40000=0; //�������װ�

				long lngBA41000=0;  //����¡���ҵ漼
				long lngBA42000=0;  //����¡������ҵ漼
				long lngBA43000=0;  //����¡����Ư��
				long lngBA40000=0;  //����¡�����װ�

				long lngCBP41000=0;  //�ⳳ�μҵ漼    
				long lngCBP42000=0;  //�ⳳ������ҵ漼
				long lngCBP43000=0;  //�ⳳ�γ�Ư��    
				long lngCBP40000=0;  //�ⳳ�μ��װ�    

        long[] lngBAAMT = new long[3];  //����/�����/�ξ簡������
				long[] lngADAMT = new long[6];  //��ο��/�����/�γ���/�ڳ������/����Ծ���/���ڳ��߰�����

				long lngPENAMT01 =0;  //���ο��ݺ����
        long lngPENAMT03 =0;  //�ٷ�����������

				long[] lngINSAMT = new long[4];  //�ǰ������//��뺸���//���强�����/��������뺸���
				long lngMEDSUM =0;    //�Ƿ��
				long lngEDUSUM =0;    //������
				long lngHOUAMT01 =0;  //�����������Ա�
				long lngHOUAMT02 =0;  //������
				long lngHOUAMT03 =0;  //�����������Ա�
				long lngCONAMT =0;    //��α�
				long lngSPCSUM =0;    //Ư��������
				long lngSTDSUM =0;    //ǥ�ذ���
				long lngOFFSUM =0;    //�����ҵ�ݾ�
				long[] lngPESAMT = new long[2];  //���ο�������/��������
				long[] lngSAVAMT = new long[4];  //û������/�ٷ������ø�������/����û����������/������ø�������
				long lngCRDSUM =0;    //�ſ�ī��
				long lngFNDSUM =0;    //����ֽ��� �������
				long lngETCSUM =0;    //�׹��Ǽҵ������
				long lngTAXSTDAMT =0; //���ռҵ����ǥ��
				long lngTAXSUM =0;    //���⼼��
				long lngDEDAMT01 =0;  //�ٷμҵ漼�װ���
				long lngDEDAMT02 =0;  //�������ռ��װ���
				long lngDEDAMT03 =0;  //�������Լ��װ���
				long lngDEDAMT04 =0;  //�����ġ���װ���
				long lngDEDAMT05 =0;  //�ܱ����μ��װ���
				long lngDEDSUM =0;    //���װ�����

				long lngTempSum=0; 

				long lngChkamt01 =0;  //�ѵ�üũ���� ��α� �ѵ� üũ ������ �ٷμҵ�ݾ� ���� �ܾ�
  
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
						lngChkSum = 0; //�ѵ� üũ�ݾ� 
						lngCCP41000=0;   //�����ҵ漼
						lngCCP42000=0;   //��������ҵ漼
						lngCCP43000=0;   //������Ư��
						lngCCP40000=0;   //�������װ�
            lngBA41000=0;    //����¡���ҵ漼     
						lngBA42000=0;	   //����¡������ҵ漼 
						lngBA43000=0;	   //����¡����Ư��     
						lngBA40000=0;	   //����¡�����װ�     
						lngCBP41000=0;   //�ⳳ�μҵ漼     
						lngCBP42000=0;	 //�ⳳ������ҵ漼 
						lngCBP43000=0;	 //�ⳳ�γ�Ư��     
						lngCBP40000=0;	 //�ⳳ�μ��װ�     
						lngPENAMT01 =0;  //���ο��ݺ����
						lngPENAMT03 =0;  //�ٷ�����������
						lngMEDSUM =0;    //�Ƿ��
						lngEDUSUM =0;    //������
						lngHOUAMT01 =0;  //�����������Ա�
						lngHOUAMT02 =0;  //������
						lngHOUAMT03 =0;  //�����������Ա�
						lngCONAMT =0;    //��α�
						lngSPCSUM =0;    //Ư��������
						lngSTDSUM =0;    //ǥ�ذ���
						lngOFFSUM =0;    //�����ҵ�ݾ�
						lngCRDSUM =0;    //�ſ�ī��
						lngFNDSUM =0;    //����ֽ��� �������
						lngETCSUM =0;    //�׹��Ǽҵ������
						lngTAXSTDAMT =0; //���ռҵ����ǥ��
						lngTAXSUM =0;    //���⼼��
						lngDEDAMT01 =0;  //�ٷμҵ漼�װ��� 
						lngDEDAMT02 =0;  //�������ռ��װ��� 
						lngDEDAMT03 =0;  //�������Լ��װ��� 
						lngDEDAMT04 =0;  //�����ġ���װ��� 
						lngDEDAMT05 =0;  //�ܱ����μ��װ��� 
						lngDEDSUM =0;    //���װ�����       


						lngTempSum=0;					

						for(int i=0;i<2;i++){
							lngINSAMT[i]=0;
							lngPESAMT[i]=0;
						}

						for(int i=0;i<3;i++){
							lngBAAMT[i]=0;
						}

						for(int i=0;i<4;i++){
							lngSAVAMT[i]=0;
						}

				    for(int i=0;i<6;i++){
							lngADAMT[i]=0;
						}

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT                                                                   \n" ); 
						SelectSql.append( " 		APPYY,      EMPNO,      EMPNMK,     MGENO,                           \n" ); 
						SelectSql.append( " 		CCP41000,   CCP42000,   CCP43000,   CCP40000,                        \n" ); 
						SelectSql.append( " 		BP41000,    BP42000,    BP43000,    BP40000,                         \n" ); 
            SelectSql.append( " 		BP51000,    BP52000,    BP53000,    BP50000,                         \n" ); 
						SelectSql.append( " 		BP61000,    BP62000,    BP63000,    BP60000,                         \n" ); 
						SelectSql.append( " 		CP41000,    CP42000,    CP43000,    CP40000,                         \n" ); 
						SelectSql.append( " 		BP41000+BP51000+BP61000+CP41000 AS CBP41000,                         \n" ); 
            SelectSql.append( " 		BP42000+BP52000+BP62000+CP42000 AS CBP42000,                         \n" ); 
						SelectSql.append( " 		BP43000+BP53000+BP63000+CP43000 AS CBP43000,                         \n" ); 
						SelectSql.append( " 		BP40000+BP50000+BP60000+CP40000 AS CBP40000,                         \n" ); 
						SelectSql.append( " 		BA41000,    BA42000,    BA43000,    BA40000,                         \n" ); 
						SelectSql.append( " 		TOTPAY,     DUDPAY,     LABPAY,                                      \n" ); 
						SelectSql.append( " 		BAAMT01,    BAAMT02,    BACNT03,    BAAMT03,                         \n" ); 
						SelectSql.append( " 		ADCNT01,    ADAMT01,    ADCNT02,    ADAMT02,    ADAMT03,             \n" ); 
						SelectSql.append( " 		ADCNT04,    ADAMT04,    ADCNT05,    ADAMT05,    ADCNT06,    ADAMT06, \n" );
						SelectSql.append( " 		PENAMT01,   PENAMT03,                                                \n" ); 
						SelectSql.append( " 		INSAMT01,   INSAMT02,   INSAMT03,   INSAMT04,                        \n" ); 
						SelectSql.append( " 		MEDSUM,     EDUSUM,     HOUAMT01,   HOUAMT02,   HOUAMT03,            \n" );
						SelectSql.append( " 		CONAMT,     SPCSUM,     STDSUM,     OFFSUM,                          \n" ); 
						SelectSql.append( " 		PESAMT01,   PESAMT02,   SMAAMT,                                      \n" ); 
						SelectSql.append( " 		SAVAMT01,   SAVAMT02,   SAVAMT03,   SAVAMT04,                        \n" ); 
						SelectSql.append( " 		INVSUM,     CRDSUM,     ASSSUM,     FNDSUM,     ETCSUM,              \n" ); 
						SelectSql.append( " 		TAXSTDAMT,  TAXSUM,     TREDAMT01,  TREDAMT02,  TREDSUM,             \n" ); 
            SelectSql.append( " 		DEDAMT01,   DEDAMT02,   DEDAMT03,   DEDAMT04,   DEDAMT05,   DEDSUM   \n" ); 
						SelectSql.append( "  FROM PAYROLL.YCPAY10                                                    \n" ); 
						SelectSql.append( "  WHERE APPYY='"+rows[j].getString(idxAPPYY)+"'	 \n" ); 
						SelectSql.append( "    AND EMPNO ='"+rows[j].getString(idxEMPNO)+"'	 \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							lngChkSum = rs.getLong("LABPAY");     //�ٷμҵ�����ݾ� üũ
							lngBAAMT[0]= rs.getLong("BAAMT01"); 
							lngBAAMT[1]= rs.getLong("BAAMT02"); 
							lngBAAMT[2]= rs.getLong("BAAMT03"); 
              lngADAMT[0]= rs.getLong("ADAMT01");  
							lngADAMT[1]= rs.getLong("ADAMT02"); 
							lngADAMT[2]= rs.getLong("ADAMT03"); 
							lngADAMT[3]= rs.getLong("ADAMT04"); 
							lngADAMT[4]= rs.getLong("ADAMT05"); 
              lngADAMT[5]= rs.getLong("ADAMT06");  
							lngPENAMT01= rs.getLong("PENAMT01");  
							lngPENAMT03= rs.getLong("PENAMT03");
							lngINSAMT[0]= rs.getLong("INSAMT01");
							lngINSAMT[1]= rs.getLong("INSAMT02");
							lngINSAMT[2]= rs.getLong("INSAMT03");
							lngINSAMT[3]= rs.getLong("INSAMT04");
							lngMEDSUM=rs.getLong("MEDSUM");
							lngEDUSUM=rs.getLong("EDUSUM");
							lngHOUAMT01= rs.getLong("HOUAMT01");
							lngHOUAMT02= rs.getLong("HOUAMT02");
							lngHOUAMT03= rs.getLong("HOUAMT03");
							lngCONAMT = rs.getLong("CONAMT");
							lngSPCSUM = rs.getLong("SPCSUM");
							lngSTDSUM = rs.getLong("STDSUM");
							lngOFFSUM = rs.getLong("OFFSUM");
              lngPESAMT[0]= rs.getLong("PESAMT01");
							lngPESAMT[1]= rs.getLong("PESAMT02");
							lngSAVAMT[0]= rs.getLong("SAVAMT01");
							lngSAVAMT[1]= rs.getLong("SAVAMT02");
							lngSAVAMT[2]= rs.getLong("SAVAMT03");
							lngSAVAMT[3]= rs.getLong("SAVAMT04");
							lngCRDSUM=rs.getLong("CRDSUM");
							lngFNDSUM=rs.getLong("FNDSUM");
							lngETCSUM=rs.getLong("ETCSUM");
              lngTAXSTDAMT =rs.getLong("TAXSTDAMT");
							lngTAXSUM =rs.getLong("TAXSUM");
							lngDEDAMT01 =rs.getLong("DEDAMT01");
							lngDEDAMT02 =rs.getLong("DEDAMT02");
							lngDEDAMT03 =rs.getLong("DEDAMT03");
							lngDEDAMT04 =rs.getLong("DEDAMT04");
							lngDEDAMT05 =rs.getLong("DEDAMT05");
							lngDEDSUM =rs.getLong("DEDSUM");

							lngCBP41000=rs.getLong("CBP41000");  //�ⳳ�μҵ漼    
							lngCBP42000=rs.getLong("CBP42000");  //�ⳳ������ҵ漼
							lngCBP43000=rs.getLong("CBP43000");  //�ⳳ�γ�Ư��    
							lngCBP40000=rs.getLong("CBP40000");  //�ⳳ�μ��װ�     
            																			
              //���ΰ��� 
							if(lngChkSum>0){ 
								if(lngBAAMT[0]>0)lngChkSum -= lngBAAMT[0];
								if(lngChkSum<0){
									lngBAAMT[0] = lngBAAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngBAAMT[0]=0;
							}

							//�����
							if(lngChkSum>0){
								if(lngBAAMT[1]>0)lngChkSum -= lngBAAMT[1];
								if(lngChkSum<0){
									lngBAAMT[1] = lngBAAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngBAAMT[1]=0; 
							}

							//�ξ簡��
							if(lngChkSum>0){
								if(lngBAAMT[2] >0)lngChkSum -= lngBAAMT[2];
								if(lngChkSum<0){
									lngBAAMT[2] = lngBAAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
							  lngBAAMT[2]=0;
							}

							//��ο��
							if(lngChkSum>0){
								if(lngADAMT[0]>0) lngChkSum -= lngADAMT[0];
								if(lngChkSum<0){
									lngADAMT[0] = lngADAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[0] =0;
							}

							//�����
							if(lngChkSum>0){
								if(lngADAMT[1]>0) lngChkSum -= lngADAMT[1];
								if(lngChkSum<0){
									lngADAMT[1] = lngADAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[1]=0;
							}

							//�γ���
							if(lngChkSum>0){
								if(lngADAMT[2]>0) lngChkSum -= lngADAMT[2];
								if(lngChkSum<0){
									lngADAMT[2] = lngADAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[2] =0;
							}

							//�ڳ����
							if(lngChkSum>0){
								if(lngADAMT[3]>0) lngChkSum -=lngADAMT[3];
								if(lngChkSum<0){
									lngADAMT[3] = lngADAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[3] =0;
							}

							//����Ծ���
							if(lngChkSum>0){
								if(lngADAMT[4]>0) lngChkSum -=lngADAMT[4];
								if(lngChkSum<0){
									lngADAMT[4] = lngADAMT[4]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[4] = 0;
							}

							//���ڳ��߰�����
							if(lngChkSum>0){
								if(lngADAMT[5]>0) lngChkSum -= lngADAMT[5];
								if(lngChkSum<0){
									lngADAMT[5] = lngADAMT[5]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngADAMT[5] =0;
							}

							//���ο���
							if(lngChkSum>0){
								if(lngPENAMT01>0) lngChkSum -= lngPENAMT01;
								if(lngChkSum<0){
									lngPENAMT01= lngPENAMT01+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPENAMT01=0;
							}

							//��������
							if(lngChkSum>0){
								if(lngPENAMT03>0) lngChkSum -= lngPENAMT03;
								if(lngChkSum<0){
									lngPENAMT03 = lngPENAMT03+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPENAMT03=0;
							}

              //�����ҵ�ݾ׿� �����ϱ� ���� �ӽ� �հ� 
              lngTempSum = rs.getLong("LABPAY") 
								         -(lngBAAMT[0]+lngBAAMT[1]+lngBAAMT[2]
								         + lngADAMT[0]+lngADAMT[1]+lngADAMT[2]+lngADAMT[3]+lngADAMT[4]+lngADAMT[5]
							           + lngPENAMT01+lngPENAMT03);	 
							//=============================================

							//�ǰ�����
							if(lngChkSum>0){
								if(lngINSAMT[0]>0) lngChkSum -= lngINSAMT[0];
								if(lngChkSum<0){
									lngINSAMT[0] = lngINSAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[0] =0;
							}

							//��뺸��
							if(lngChkSum>0){
								if(lngINSAMT[1]>0) lngChkSum -= lngINSAMT[1];
								if(lngChkSum<0){
									lngINSAMT[1] = lngINSAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[1] =0;
							}

							//���强����
							if(lngChkSum>0){
								if(lngINSAMT[2]>0) lngChkSum -= lngINSAMT[2];
								if(lngChkSum<0){
									lngINSAMT[2] = lngINSAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[2] = 0;
							}

							//����κ���
							if(lngChkSum>0){
								if(lngINSAMT[3]>0) lngChkSum -= lngINSAMT[3];
								if(lngChkSum<0){
									lngINSAMT[3] = lngINSAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngINSAMT[3] =0;
							}

							//�Ƿ��
							if(lngChkSum>0){
								if(lngMEDSUM>0) lngChkSum -= lngMEDSUM;
								if(lngChkSum<0){
									lngMEDSUM = lngMEDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngMEDSUM =0;
							}

							//������
							if(lngChkSum>0){
								if(lngEDUSUM>0) lngChkSum -= lngEDUSUM;
								if(lngChkSum<0){
									lngEDUSUM = lngEDUSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngEDUSUM = 0;
							}

							//��������
							if(lngChkSum>0){
								if(lngHOUAMT01>0) lngChkSum -= lngHOUAMT01;
								if(lngChkSum<0){
									lngHOUAMT01 = lngHOUAMT01+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT01 = 0;
							}

							//������
							if(lngChkSum>0){
								if(lngHOUAMT02>0) lngChkSum -= lngHOUAMT02;
								if(lngChkSum<0){
									lngHOUAMT02 = lngHOUAMT02+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT02 = 0;
							}

							//�����������
							if(lngChkSum>0){
								if(lngHOUAMT03>0) lngChkSum -= lngHOUAMT03;
								if(lngChkSum<0){
									lngHOUAMT03 = lngHOUAMT03+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngHOUAMT03 =0;
							}

              //�ѵ�üũ���� ��α� �ѵ� üũ ������ �ٷμҵ�ݾ� ���� �ܾ�
							lngChkamt01 = lngChkSum;

							//��α�
							if(lngChkSum>0){
								if(lngCONAMT>0) lngChkSum -=lngCONAMT;
								if(lngChkSum<0){
									lngCONAMT = lngCONAMT+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngCONAMT=0;
							}

              /////////////////////////////////////////////////////////////////////////////////
							//��α� �̿����� ����
							//1.��α��� �����ϴ��� üũ 
							//2.������ �ٷμҵ�ݾ��� ���� �ִ��� üũ
							//  2.1 �� ���� ������ ���� �̿�
							//  2.2 ��αݾ� ��ŭ ���� ������ �̿� ����.
							//  2.3 ��αݾ׺��� ������.....�����ѵ� �ٽ� üũ�ؾ��ϳ�?(????????????????????)

							/////////////////////////////////////////////////////////////////////////////////
              

              //Ư��������
       				lngSPCSUM=lngINSAMT[0]+lngINSAMT[1]+lngINSAMT[2]+lngINSAMT[3]+lngMEDSUM
                       +lngEDUSUM+lngHOUAMT01+lngHOUAMT02+lngHOUAMT03+lngCONAMT;
							
							//ǥ�ذ��� �� �����ҵ�ݾ�
							if(lngSPCSUM<1000000){
								//lngSPCSUM=0;  2011.02.20 Ư��������� ��������.
                lngSTDSUM=1000000;
								lngChkSum =lngTempSum-lngSTDSUM;
								if(lngChkSum<0){
									lngOFFSUM=0;  //�����ҵ�ݾ�
									lngChkSum=0;												
								}else{
									lngOFFSUM = lngChkSum;
								}
              }else{
								lngSTDSUM=0;
								lngOFFSUM =lngChkSum;
							}


						
							//���ο�������
							if(lngChkSum>0){
								if(lngPESAMT[0]>0) lngChkSum -=lngPESAMT[0];
								if(lngChkSum<0){
									lngPESAMT[0] = lngPESAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
								lngPESAMT[0] =0;
							}

							//��������
							if(lngChkSum>0){
               	//���������� 0�� �ƴ� ��� ( �������� + �������� �հ� �ѵ� 300���� ) 
								if(lngPENAMT03!=0){
									lngPESAMT[1] = 3000000-lngPENAMT03;
								}

								if(lngPESAMT[1]>0) lngChkSum -=lngPESAMT[1];
								if(lngChkSum<0){
									lngPESAMT[1] = lngPESAMT[1]+lngChkSum;
									lngChkSum=0;							
								}						
							}else{
								lngPESAMT[1] = 0;
							}

							//û������
							if(lngChkSum>0){
								if(lngSAVAMT[0]>0) lngChkSum -=lngSAVAMT[0];
								if(lngChkSum<0){
									lngSAVAMT[0] = lngSAVAMT[0]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[0] =0;
							}

							//�ٷ������ø�������
							if(lngChkSum>0){
								if(lngSAVAMT[1]>0) lngChkSum -=lngSAVAMT[1];
								if(lngChkSum<0){
									lngSAVAMT[1] = lngSAVAMT[1]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[1] =0;
							}

							//����û����������
							if(lngChkSum>0){
								if(lngSAVAMT[2]>0) lngChkSum -=lngSAVAMT[2];
								if(lngChkSum<0){
									lngSAVAMT[2] = lngSAVAMT[2]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[2] = 0;
							}

							//������ø������� 
              if(lngChkSum>0){
								if(lngSAVAMT[3]>0) lngChkSum -=lngSAVAMT[3];
								if(lngChkSum<0){
									lngSAVAMT[3] = lngSAVAMT[3]+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngSAVAMT[3] =0;
							}

							//�ſ�ī���
							if(lngChkSum>0){
								if(lngCRDSUM>0) lngChkSum -=lngCRDSUM;
								if(lngChkSum<0){
									lngCRDSUM = lngCRDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngCRDSUM = 0;
							}

							//����ֽ����ҵ����
							if(lngChkSum>0){
								if(lngFNDSUM>0) lngChkSum -=lngFNDSUM;
								if(lngChkSum<0){
									lngFNDSUM = lngFNDSUM+lngChkSum;
									lngChkSum=0;							
								}
							}else{
                lngFNDSUM =0;
							}

							//�� ���� �ҵ����
              lngETCSUM = lngPESAMT[0]+lngPESAMT[1]
                        + lngSAVAMT[0]+lngSAVAMT[1]+lngSAVAMT[2]+lngSAVAMT[3]
                        + lngCRDSUM+lngFNDSUM;

							//���ռҵ����ǥ��
							if(lngChkSum>0){
								lngTAXSTDAMT = lngChkSum;
							}

							//���⼼��
							if(lngTAXSTDAMT<=0){
								lngTAXSUM =0;
							}else if (lngTAXSTDAMT>0&&lngTAXSTDAMT<=12000000){
								lngTAXSUM = lngTAXSTDAMT*6/100;
							}else if (lngTAXSTDAMT>12000000&&lngTAXSTDAMT<=46000000){
								lngTAXSUM = (lngTAXSTDAMT*15/100)-1080000;
							}else if (lngTAXSTDAMT>46000000&&lngTAXSTDAMT<=88000000){
								lngTAXSUM = (lngTAXSTDAMT*24/100)-5220000;
							}else if (lngTAXSTDAMT>88000000){
								lngTAXSUM = (lngTAXSTDAMT*35/100)-14900000;
							}

							//���װ���� (��� �н�)

              //////////////////////////////////////////////////////////
              //���װ���
              //////////////////////////////////////////////////////////
							//�ٷμҵ漼�װ���
							if(lngTAXSUM<=500000){
								lngDEDAMT01 = (long)(lngTAXSUM*55)/100;
							}else{
								lngDEDAMT01 = 275000+(long)(lngTAXSUM-500000)*3/10;
								if(lngDEDAMT01>500000){
									lngDEDAMT01=500000;
								}
							}

							//�������ռ��װ��� �н� 
							//�̺о�����������Ա� ��ȯ���ڼ��װ���(��� �н�).
							//�����ġ�ڱ�
							if(lngDEDAMT04>100000){
								lngDEDAMT04=100000;
							}

							//�ܱ����μ��װ���(���� ���� �Է�) �ϴ� �н� 
              //�Ǵ������ �ܱ����μ��� 
							if(rs.getString("EMPNO").equals("1990033")){
								lngDEDAMT05 = 1228430;
							}
			

							//���װ�����
              lngDEDSUM = lngDEDAMT01+lngDEDAMT02+lngDEDAMT03+lngDEDAMT04+lngDEDAMT05;

							//�������� ( ���⼼�� - ���װ��� - ���װ��� )
              if(lngTAXSUM-lngDEDSUM<0){
								lngCCP41000=0;
							}else{
                lngCCP41000=(long)(lngTAXSUM-lngDEDSUM); //�����ҵ漼   
							}

							lngCCP42000=lngCCP41000*1/10; //��������ҵ漼
							lngCCP43000=0; //������Ư��    
							lngCCP40000=lngCCP41000+lngCCP42000; //�������װ�    

							if(lngCCP40000<0){
								lngCCP40000=0;
							}

							//����¡���� = �������� - �ⳳ�μ���
              lngBA41000 = lngCCP41000 - lngCBP41000;
              lngBA41000 = lngBA41000/10;
							lngBA41000 = lngBA41000*10;

              lngBA42000 = lngCCP42000 - lngCBP42000;
              lngBA42000 = lngBA42000/10;
							lngBA42000 = lngBA42000*10;
							//lngBA43000 = lngCCP43000 - lngCBP43000;
							//lngBA40000 = lngCCP40000 - lngCBP40000;
              lngBA40000 = lngBA41000 + lngBA42000;						

   						//logger.dbg.prlngln(this,"step2::"+lngChkSum);
         
						  /////////////////////////////////////////////////////////////////////////////////////////////
							//0 ���޸��� UPDATE 
						  /////////////////////////////////////////////////////////////////////////////////////////////
							
							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET \n");   
							UpdateSql.append( "  CCP41000 = "+lngCCP41000+" \n");  //�����ҵ漼           
							UpdateSql.append( " ,CCP42000 = "+lngCCP42000+" \n");  //��������ҵ漼       
							UpdateSql.append( " ,CCP43000 = "+lngCCP43000+" \n");  //������Ư��           
							UpdateSql.append( " ,CCP40000 = "+lngCCP40000+" \n");  //�������װ�           
              UpdateSql.append( " ,BA41000  = "+lngBA41000+"  \n");  //����¡���ҵ漼       
							UpdateSql.append( " ,BA42000  = "+lngBA42000+"  \n");  //����¡������ҵ漼   
							UpdateSql.append( " ,BA43000  = "+lngBA43000+"  \n");  //����¡����Ư��       
							UpdateSql.append( " ,BA40000  = "+lngBA40000+"  \n");  //����¡�����װ�       
							UpdateSql.append( " ,BAAMT01  = "+lngBAAMT[0]+" \n");  //����       
							UpdateSql.append( " ,BAAMT02  = "+lngBAAMT[1]+" \n");  //�����     
							UpdateSql.append( " ,BAAMT03  = "+lngBAAMT[2]+" \n");  //�ξ簡��
							UpdateSql.append( " ,ADAMT01  = "+lngADAMT[0]+" \n");  //���
							UpdateSql.append( " ,ADAMT02  = "+lngADAMT[1]+" \n");  //���
							UpdateSql.append( " ,ADAMT03  = "+lngADAMT[2]+" \n");  //�γ���
							UpdateSql.append( " ,ADAMT04  = "+lngADAMT[3]+" \n");  //�ڳ����
							UpdateSql.append( " ,ADAMT05  = "+lngADAMT[4]+" \n");  //����Ծ�
							UpdateSql.append( " ,ADAMT06  = "+lngADAMT[5]+" \n");  //���ڳ�
							UpdateSql.append( " ,PENAMT01 = "+lngPENAMT01+" \n");  //���ο���
							UpdateSql.append( " ,PENAMT03 = "+lngPENAMT03+" \n");  //��������
							UpdateSql.append( " ,INSAMT01 = "+lngINSAMT[0]+"\n");  //�ǰ�����
							UpdateSql.append( " ,INSAMT02 = "+lngINSAMT[1]+"\n");  //��뺸��
							UpdateSql.append( " ,INSAMT03 = "+lngINSAMT[2]+"\n");  //���强����
							UpdateSql.append( " ,INSAMT04 = "+lngINSAMT[3]+"\n");  //����κ���
							UpdateSql.append( " ,MEDSUM   = "+lngMEDSUM+"   \n");  //�Ƿ�
							UpdateSql.append( " ,EDUSUM   = "+lngEDUSUM+"   \n");  //����
							UpdateSql.append( " ,HOUAMT01 = "+lngHOUAMT01+" \n");  //�����������Ա�
							UpdateSql.append( " ,HOUAMT02 = "+lngHOUAMT02+" \n");  //������
							UpdateSql.append( " ,HOUAMT03 = "+lngHOUAMT03+" \n");  //�����������Ա�
							UpdateSql.append( " ,CONAMT   = "+lngCONAMT+"   \n");  //��α�
							UpdateSql.append( " ,SPCSUM   = "+lngSPCSUM+"   \n");  //Ư������
							UpdateSql.append( " ,STDSUM   = "+lngSTDSUM+"   \n");  //ǥ�ذ���
							UpdateSql.append( " ,OFFSUM   = "+lngOFFSUM+"   \n");  //�����ҵ�ݾ�
							UpdateSql.append( " ,PESAMT01 = "+lngPESAMT[0]+"\n");  //���ο���
							UpdateSql.append( " ,PESAMT02 = "+lngPESAMT[1]+"\n");  //��������
							UpdateSql.append( " ,SAVAMT01 = "+lngSAVAMT[0]+"\n");  //û������
							UpdateSql.append( " ,SAVAMT02 = "+lngSAVAMT[1]+"\n");  //�ٷ������ø�������
							UpdateSql.append( " ,SAVAMT03 = "+lngSAVAMT[2]+"\n");  //����û����������
							UpdateSql.append( " ,SAVAMT04 = "+lngSAVAMT[3]+"\n");  //������ø�������
							UpdateSql.append( " ,CRDSUM   = "+lngCRDSUM+"   \n");  //�ſ�ī��
							UpdateSql.append( " ,FNDSUM   = "+lngFNDSUM+"   \n");  //�ݵ�
							UpdateSql.append( " ,ETCSUM   = "+lngETCSUM+"   \n");  //�׹��Ǽҵ������
							UpdateSql.append( " ,TAXSTDAMT= "+lngTAXSTDAMT+"\n");  //���ռҵ����ǥ��
							UpdateSql.append( " ,TAXSUM   = "+lngTAXSUM +"  \n");  //���⼼��
							UpdateSql.append( " ,DEDAMT01 = "+lngDEDAMT01+" \n");  //�ٷμҵ漼�װ���
							UpdateSql.append( " ,DEDAMT02 = "+lngDEDAMT02+" \n");  //�������ռ��װ���
							UpdateSql.append( " ,DEDAMT03 = "+lngDEDAMT03+" \n");  //�������Լ��װ���
							UpdateSql.append( " ,DEDAMT04 = "+lngDEDAMT04+" \n");  //�����ġ���װ���
							UpdateSql.append( " ,DEDAMT05 = "+lngDEDAMT05+" \n");  //�ܱ����μ��װ���
							UpdateSql.append( " ,DEDSUM   = "+lngDEDSUM+"   \n");  //���װ�����
							UpdateSql.append( " ,CHKAMT01 = "+lngChkamt01+" \n");  //�ѵ�üũ���� ��α� �ѵ� üũ ������ �ٷμҵ�ݾ� ���� �ܾ�
							//����� ��ü 
							UpdateSql.append( " ,NTAXSUM01 = CNTAX01+BNTAX101+BNTAX201+BNTAX301 \n");  //01
							UpdateSql.append( " ,NTAXSUM02 = CNTAX02+BNTAX102+BNTAX202+BNTAX302 \n");  //02
							UpdateSql.append( " ,NTAXSUM03 = CNTAX03+BNTAX103+BNTAX203+BNTAX303 \n");  //03
							UpdateSql.append( " ,NTAXSUM04 = CNTAX04+BNTAX104+BNTAX204+BNTAX304 \n");  //04
							UpdateSql.append( " ,NTAXSUM05 = CNTAX05+BNTAX105+BNTAX205+BNTAX305 \n");  //05
							UpdateSql.append( " ,NTAXSUM = CNTAXSUM+BNTAX1SUM+BNTAX2SUM+BNTAX3SUM \n");  //����� ��ü �հ�
							UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							logger.dbg.println(this,"step16");
												
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