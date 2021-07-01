package Ehr.idt.b.idtb001.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTB001DAO extends AbstractDAO {
	/**
	 * IDTB001DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTB001DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ������Ȳ�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB001_SHR(CBox p_box) throws CException {

		
		
		String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String CEF_DOC_SHR    = JSPUtil.rns(p_box.get("CEF_DOC_SHR")); 							// ����
		String ENO_NM_SHR     = JSPUtil.rns(p_box.get("ENO_NM_SHR")); 							// ����

		//System.out.println("p_box   =========================================== " + p_box);
        
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB001_SHR");

		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				
				p_box.getString("ENO_NM_SHR")              // ����
				//JSPUtil.rns(p_box.get("ENO_NM_SHR"))
				//JSPUtil.rns(p_box.get("CEF_DOC_SHR")),				
                //JSPUtil.rns(p_box.get("ENO_NM_SHR")),
				//ENO_NM
                
        };

		
		
		/** ��ȸ ����(�������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.FROM_YMD >= '"+STR_YMD_SHR+"' ");
			sb.append("AND A.FROM_YMD <= '"+END_YMD_SHR+"' \n");
		}

		
		
		// ���� ����
		if( !CEF_DOC_SHR.equals("0") && !CEF_DOC_SHR.equals("")){
			sb.append("AND A.CD_GBN = '"+CEF_DOC_SHR+"' \n");
		}
		
        
        
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//prop.add("CEF_STS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("CET_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		
		this.selectProcessFirstRow(sql, bind, prop);
		
		
		
		
	}

	
	
	
	
	/**
	 * �ڵ� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB001_SHR_COD(CBox p_box) throws CException {

		
		
		//String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		//String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		//String CEF_DOC_SHR    = JSPUtil.rns(p_box.get("CEF_DOC_SHR")); 							// ����
		
		
		String GBN         = JSPUtil.rns(p_box.get("GBN")); 		

		
		
		//System.out.println("p_box   =========================================== " + p_box);
        
		
		
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB001_SHR_COD");

		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				//JSPUtil.rns(p_box.get("GBN")),	

				JSPUtil.rns(p_box.get("COMM_CD")),				
                //JSPUtil.rns(p_box.get("ENO_NM_SHR"))
				//ENO_NM
                
        };

		
		/** ��ȸ ����(�������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		
		if (GBN.equals("A")) {
			
			sb.append("AND SUBSTR(CD_GBN, 1, 1) = 'A' \n");
			
		} else if (GBN.equals("C")) {
			
			sb.append("AND SUBSTR(CD_GBN, 1, 1) = 'C' \n");
			
		} else if (GBN.equals("AC")) {
			
			sb.append("AND (SUBSTR(CD_GBN, 1, 1) = 'A'  OR SUBSTR(CD_GBN, 1, 1) = 'C') \n");
			
		} else if (GBN.equals("S")) {
			
			sb.append("AND SUBSTR(CD_GBN, 1, 1) = 'S' \n");			
			
		} else if (GBN.equals("P")) {
			
			sb.append("AND SUBSTR(CD_GBN, 1, 1) = 'P' \n");					
			
			
		}
		
		
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		


		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		//prop.add("CEF_STS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("CET_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		
		this.selectProcessFirstRow(sql, bind, prop);
		

	}




	/**
	 * ���� �߱� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB001_INS(GauceValueObject vo, CBox p_box) throws CException {

		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB001_INS");

		
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("vo"+vo.toString());	  		
		
		String YYMM   = JSPUtil.rns(p_box.get("vcurdate").replaceAll("-", "")).substring(0,6);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				YYMM,
				YYMM,
				JSPUtil.rns(vo.get("CD_GBN")),     	// A:������ B:����� C:��������� D:��������� E:�������ȸ�� F:�������� H:������༭
				JSPUtil.rns(vo.get("ENO_NM")),    	// �̸�
				JSPUtil.rns(vo.get("FROM_YMD")),    // ������
				JSPUtil.rns(vo.get("TO_YMD")),    	// ��ೡ
				JSPUtil.rns(vo.get("MONTH")),     	// ��ళ����
				JSPUtil.rns(vo.get("PROJECT_NM")),	// ������Ʈ��
				JSPUtil.rns(vo.get("PRO_FROM")),	// ������Ʈ������
				JSPUtil.rns(vo.get("PRO_TO")),		// ������Ʈ������
				JSPUtil.rns(vo.get("WPLACE_NM")),	// �ٹ���
				
				JSPUtil.rns(vo.get("SITE_CD")),		// �����ڵ�
				JSPUtil.rns(vo.get("SITE_NM")),		// �����						
				
				JSPUtil.rns(vo.get("JOB_CD")),		// ����
				JSPUtil.rns(vo.get("HOB_CD")),		// ����	
				JSPUtil.rns(vo.get("SRV_CD")),		// ����
				JSPUtil.rns(vo.get("WORK_NM")),		// ����
				JSPUtil.rns(vo.get("CALL_NM")),		// ȣĪ			
				

				JSPUtil.rns(vo.get("P01_AMT")),		// �⺻��	
				JSPUtil.rns(vo.get("P02_AMT")),		// �ð��ܼ���
				JSPUtil.rns(vo.get("P03_AMT")),		// ���ϱٷμ���
				JSPUtil.rns(vo.get("P04_AMT")),		// Ư��������	
				JSPUtil.rns(vo.get("P05_AMT")),		// ��������
				
				JSPUtil.rns(p_box.get("SUM_AMT")),	
				
			};

			/** INSERT�޼ҵ� ȣ��  **/
			insertProcess(sql, bind);
		}

	

	/**
	 * ���� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB001_UPT(GauceValueObject vo, CBox p_box) throws CException {

		
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB001_UPT");

		
    	//System.out.println("vo"+vo.toString());	
    	//System.out.println("p_box"+p_box.toString());	
    	
    	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("CD_GBN")),     	// A:������ B:����� C:��������� D:��������� E:�������ȸ�� F:�������� H:������༭
				JSPUtil.rns(vo.get("ENO_NM")),    	// �̸�
				JSPUtil.rns(vo.get("FROM_YMD")),    // ������
				JSPUtil.rns(vo.get("TO_YMD")),    	// ��ೡ
				JSPUtil.rns(vo.get("MONTH")),     	// ��ళ����
				JSPUtil.rns(vo.get("PROJECT_NM")),	// ������Ʈ��
				JSPUtil.rns(vo.get("PRO_FROM")),	// ������Ʈ������
				JSPUtil.rns(vo.get("PRO_TO")),		// ������Ʈ������
				JSPUtil.rns(vo.get("WPLACE_NM")),	// �ٹ���
				
				JSPUtil.rns(vo.get("SITE_CD")),		// �����ڵ�
				JSPUtil.rns(vo.get("SITE_NM")),		// �����			
				
				JSPUtil.rns(vo.get("JOB_CD")),		// ����
				JSPUtil.rns(vo.get("HOB_CD")),		// ����	
				JSPUtil.rns(vo.get("SRV_CD")),		// ����
				JSPUtil.rns(vo.get("WORK_NM")),		// ����
				JSPUtil.rns(vo.get("CALL_NM")),		// ȣĪ		
	
				

				JSPUtil.rns(vo.get("P01_AMT")),		// �⺻��	
				JSPUtil.rns(vo.get("P02_AMT")),		// �ð��ܼ���
				JSPUtil.rns(vo.get("P03_AMT")),		// ���ϱٷμ���
				JSPUtil.rns(vo.get("P04_AMT")),		// Ư��������	
				JSPUtil.rns(vo.get("P05_AMT")),		// ��������
				

				JSPUtil.rns(p_box.get("SUM_AMT")),	

				
				JSPUtil.rns(vo.get("SID")),			// SID					
				
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	
	/**
	 * ���� ������ �����ϴ�  DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void IDTB001_DEL(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB001_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SID"))
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	
	
}
