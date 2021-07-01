package Ehr.edu.g.edug030.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG030DAO extends AbstractDAO {
	/**
	 * EDUG030DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR");

		StringBuffer sb = new StringBuffer();
		
		if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2040024")){
			sb.append(" AND A.TRA_ENO_NO = '2040024' ");
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2070027")){
			sb.append(" AND A.TRA_ENO_NO = '2070027' ");			
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2120008")){
			sb.append(" AND A.TRA_ENO_NO = '2120008' ");		
		}else if(p_box.get("MNT_GBN").equals("M") && p_box.get("ENO_NO").equals("2130021")){
			sb.append(" AND A.TRA_ENO_NO = '2130021' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170006")){
			sb.append(" AND A.ENO_NO = '2170006' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170007")){
			sb.append(" AND A.ENO_NO = '2170007' ");				
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170008")){
			sb.append(" AND A.ENO_NO = '2170008' ");			
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170009")){
			sb.append(" AND A.ENO_NO = '2170009' ");				
		}else if(p_box.get("MNT_GBN").equals("P") && p_box.get("ENO_NO").equals("2170012")){
			sb.append(" AND A.ENO_NO = '2170012' ");						
		}else{	
			sb.append(" AND 1=1            ");
		}		
		
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);			
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				//p_box.get("ENO_NO")                         // ���
				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG030_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_WEEK")                        // SEQ��ȣ
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	public void EDUG030_SHR_31(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_31");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_WEEK")                        // SEQ��ȣ
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	public void EDUG030_SHR_32(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_32");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_WEEK"),                       // SEQ��ȣ
				p_box.get("TRA_YMD")                         // SEQ��ȣ				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	public void EDUG030_SHR_33(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_33");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_WEEK"),                       // SEQ��ȣ
				p_box.get("TRA_YMD")                         // SEQ��ȣ				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	

	public void EDUG030_SHR_34(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_34");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_YMD")                         // SEQ��ȣ				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	public void EDUG030_SHR_35(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SHR_35");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_YMD")                         // SEQ��ȣ				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // ���
				vo.get("TRA_WEEK"),                                  // ����
				vo.get("TRA_YMD").replaceAll("-", ""),     			// ����
				vo.get("TRA_PLACE"),                                 // ���
				vo.get("TRA_SUBJECT"),                              // ����
				vo.get("TRA_ENO_NO"),                              // ������
				vo.get("TRA_CONTENT"),                            // ��������
				vo.get("TRA_REMARK"),                              // �ǰ�
				p_box.get("vusrid"),                 				  // �Է���
				p_box.get("vusrid")                  				  // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * SUBMIT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_SUB");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // ���
				vo.get("TRA_WEEK"),                                  // ����
				vo.get("TRA_YMD").replaceAll("-", ""),     			// ����

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	
	/**
	 * �������� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_SUB2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_APP");
		
		
		String REQ_NO = vo.get("ENO_NO") + vo.get("TRA_YMD").replaceAll("-", "").substring(4,8);		
		String GUN_DPT;
		String ENO_NO;
		String JOB_CD;	

		
		if(p_box.get("ENO_NO").equals("2170006") || p_box.get("ENO_NO").equals("2170007") || p_box.get("ENO_NO").equals("2170012")){
			
			GUN_DPT = "II30";
			ENO_NO = "2120021";
			JOB_CD = "140"; 
			
		}else if(p_box.get("ENO_NO").equals("2170008")){
			
			GUN_DPT = "KK80";			
			ENO_NO = "2030009";		
			JOB_CD = "180"; 
			
		}else if(p_box.get("ENO_NO").equals("2170009")){
			
			GUN_DPT = "KK70";			
			ENO_NO = "1990040";				
			JOB_CD = "180";
					
		}else{
			
			GUN_DPT = "CC20";	
			ENO_NO = "6060002";			
			JOB_CD = "200";
			
		}

		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				REQ_NO,
				"1",
				"L",
				GUN_DPT,
				vo.get("ENO_NO"),                                     // �����				
				ENO_NO,                                                 // ������
				JOB_CD,
				vo.get("ENO_NO"),                                     // ���
				vo.get("ENO_NO"),                                     // �����				
				vo.get("TRA_YMD").replaceAll("-", ""),     			// ����

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * SUBMIT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_ACC(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_ACC");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                     // ���
				vo.get("TRA_YMD").replaceAll("-", ""),     			// ����

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * SUBMIT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_ACC2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_ACC2");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),                  				        // ������				
				p_box.get("REQ_NO"),                                      // REQ_NO


		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}		
	
	/**
	 * UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {

				vo.get("TRA_PLACE"),                         // �������
				vo.get("TRA_SUBJECT"),                      // ��������
				vo.get("TRA_ENO_NO"),                      // ������
				vo.get("TRA_CONTENT"),                     // ��������
				vo.get("TRA_REMARK"),                      // ���ǹ��ǰ�
				p_box.get("vusrid"),                           // �Է���				
				p_box.get("vusrid"),                           // ������
				vo.get("ENO_NO"),                            // ���
				vo.get("TRA_WEEK"),                          // ������
				vo.get("TRA_YMD").replaceAll("-", ""),     // ��������				
		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_UPT2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_UPT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {

				vo.get("TRA_MENTO"),                       // �����ǰ�							
				p_box.get("vusrid"),                           // ������
				vo.get("ENO_NO"),                            // ���
				vo.get("TRA_WEEK"),                          // ������
				vo.get("TRA_YMD").replaceAll("-", ""),     // ��������				
		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}	


	/**
	 * DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG030_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG030_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // �Ϸù�ȣ
				vo.get("ENO_NO")                                        // ���
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

}
