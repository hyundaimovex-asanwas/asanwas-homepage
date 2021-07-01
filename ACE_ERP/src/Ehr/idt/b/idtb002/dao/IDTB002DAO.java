package Ehr.idt.b.idtb002.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTB002DAO extends AbstractDAO {
	/**
	 * IDTB002DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTB002DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ������Ȳ�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB002_SHR(CBox p_box) throws CException {

		
		
		String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String ENO_NM         = JSPUtil.rns(p_box.get("ENO_NM_SHR")); 							

		//System.out.println("p_box   =========================================== " + p_box);
        
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_SHR");

		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				//JSPUtil.rns(p_box.get("CEF_DOC_SHR")),				
                //JSPUtil.rns(p_box.get("ENO_NM_SHR"))
				ENO_NM
                
        };

		
		/** ��ȸ ����(�������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.FROM_YMD >= '"+STR_YMD_SHR+"' ");
			sb.append("AND A.FROM_YMD <= '"+END_YMD_SHR+"' \n");
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
	 * ���� �߱� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB002_INS(GauceValueObject vo, CBox p_box) throws CException {

		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_INS");

		
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("vo"+vo.toString());	  		
		
		String YYMM   = JSPUtil.rns(p_box.get("vcurdate").replaceAll("-", "")).substring(0,6);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				YYMM,
				YYMM,
				JSPUtil.rns(vo.get("ENO_NM")),    	// �̸�
				JSPUtil.rns(vo.get("CD_GBN")),    	// 					
				JSPUtil.rns(vo.get("FROM_YMD")),    // ������
				JSPUtil.rns(vo.get("TO_YMD")),    	// ��ೡ
				JSPUtil.rns(vo.get("MONTH")),     	// ��ళ����
				JSPUtil.rns(vo.get("P01_AMT")),		// 
				JSPUtil.rns(vo.get("P02_AMT")),		// 
				JSPUtil.rns(vo.get("P03_AMT")),		// 	
				JSPUtil.rns(vo.get("P04_AMT")),		// 
				JSPUtil.rns(vo.get("P05_AMT")),		// 
				JSPUtil.rns(vo.get("SUM_AMT")),		// 			
				
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
	public void IDTB002_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("ENO_NM")),    	// �̸�
				JSPUtil.rns(vo.get("CD_GBN")),    	// 			
				JSPUtil.rns(vo.get("FROM_YMD")),    // ������
				JSPUtil.rns(vo.get("TO_YMD")),    	// ��ೡ
				JSPUtil.rns(vo.get("MONTH")),     	// ��ళ����
				JSPUtil.rns(vo.get("P01_AMT")),		// 
				JSPUtil.rns(vo.get("P02_AMT")),		// 
				JSPUtil.rns(vo.get("P03_AMT")),		// 	
				JSPUtil.rns(vo.get("P04_AMT")),		// 
				JSPUtil.rns(vo.get("P05_AMT")),		// 
				JSPUtil.rns(vo.get("SUM_AMT")),		// 		
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
	public void IDTB002_DEL(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SID"))
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	
	
}
