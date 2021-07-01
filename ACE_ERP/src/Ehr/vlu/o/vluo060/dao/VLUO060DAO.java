package Ehr.vlu.o.vluo060.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class VLUO060DAO extends AbstractDAO {
    /**
     * VLUO060DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public VLUO060DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���� ����Ʈ (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR");

		
	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // ������
	    	 sb.append("AND A.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //PJT
	    	 sb.append("AND A.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()

		};

		
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),   
				p_box.get("REG_YM_SHR"),
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),      
				p_box.get("REG_YM_SHR"),
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);	
		
		
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	
	public void VLUO060_SHR2(CBox p_box ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR2");

		
	    String GBN_CD  = p_box.get("GUBUN");

	    StringBuffer sb = new StringBuffer();
	    
	     if ( GBN_CD.equals("1") ) {  // ������
	    	 sb.append("AND A.OCC_CD != '8'");
	     } else if ( GBN_CD.equals("2") ) { //PJT
	    	 sb.append("AND A.OCC_CD ='8'");
	     } else {
	    	 sb.append("AND 2=2");
	     }

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()

		};

		
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		
		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),   
				p_box.get("REG_YM_SHR"),
				p_box.get("REG_YM_SHR"),
                p_box.get("EMPNOH"),      
				p_box.get("REG_YM_SHR"),  
 
		};

		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVGSCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);		
		
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}	
	

    /**
     * ��ȸ DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_SHR_ITEM(CBox p_box ) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_SHR_ITEM");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("HENO_NO"),                       						// �����
				p_box.get("ENO_NO"),                       							// �ǰ����
				p_box.get("GOAL_SEQ"),                       						// ����
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                     	// ������
				p_box.get("ENO_NO"),   												// �ǰ����				
				p_box.get("GOAL_SEQ"),                       						// ����				
				
		};

		
		prop.add("SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPT_CH_SCR", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
	
    /**
     * ��ǥ���� (�Է�) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_INS(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (�Է�) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_INS");

		/** ���� ����  Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                
		         JSPUtil.rns(vo.get("EVL_YYYY" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("GOAL_NO" ))
		        ,JSPUtil.rns(vo.get("WEIGHT" ))
		        ,JSPUtil.rns(vo.get("SCR" ))
		        ,JSPUtil.rns(vo.get("SCRGBN" ))
		        ,JSPUtil.rns(vo.get("DPT_CH_SCR" ))
		        ,JSPUtil.rns(vo.get("FEEDBACK" ))                
                
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}


	
	public void VLUO060_SAV_COR(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUO060_INS.PROC_CORRECT(?, ?) }";

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
	    this.executeProcedure(sql, bind, null);
	}	
	
	
	public void VLUO060_SAV_COR_01(CBox p_box) throws CException {

	    String sql = "{ call PKG_XF_VLUO060_PJT.PROC_CORRECT(?, ?) }";

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "") },
	            {"IN",      "",         JSPUtil.rns(p_box.get("EMPNOH")) }
	    };

	    /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
	    this.executeProcedure(sql, bind, null);
	}		
	
    /**
     * ��ǥ���� (����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void VLUO060_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ��ǥ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_UPT");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("WEIGHT_HEAD")),  	//����
                JSPUtil.rns(vo.get("EMPNO")), 			//                
                JSPUtil.rns(vo.get("EVASEQ")), 			//
                JSPUtil.rns(vo.get("GOAL_NO")), 		//

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	

	
	
	
	public void VLUO060_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUO060_DEL");
     
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVL_YYYY" ))
			    ,JSPUtil.rns(vo.get("EMPNOH" ))
			    ,JSPUtil.rns(vo.get("EMPNO" ))
			    ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("GOAL_NO" ))
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

}
