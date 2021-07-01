package Ehr.vlu.l.vlul010.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class VLUL010DAO extends AbstractDAO {

	public VLUL010DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	public GauceDataSet VLUL010_SHR(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // ������
				p_box.get("ENO_NO")                      					   	   // ���
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	public GauceDataSet VLUL010_SHR_00(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_00");

		Object[] bind = new Object[] {
				p_box.get("EMPNO")                      					   	   // ���
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	public GauceDataSet VLUL010_SHR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_01");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // ������
				p_box.get("ENO_NO"),                      					   	   // ���
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // ������
				p_box.get("ENO_NO")                      					   	   // ���				
		};

		prop.add("SCORE", prop.COLUMN_TYPE_DECIMAL, 2.1, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("CH_SCORE", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	public GauceDataSet VLUL010_SHR_02(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_02");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // ������
				p_box.get("ENO_NO"),                      					   	   // ���
		
		};

		prop.add("SCORE", prop.COLUMN_TYPE_DECIMAL, 2.1, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("CH_SCORE", prop.COLUMN_TYPE_DECIMAL, 3.2, prop.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	public void VLUL010_SHR_CHK(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_CHK");

		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // ������
				p_box.get("ENO_NO")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}



	public GauceDataSet VLUL010_SHR_CNT(String EVAYM, String EMPNO) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_CHK");

		Object[] bind = new Object[] {

				EVAYM.replaceAll("-", ""),
				EMPNO						//���
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}




	public void VLUL010_SHR_TERM(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_TERM");

		Object[] bind = new Object[] {
				p_box.get("evaym")

		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUL010_SHR_LENGTH(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_LENGTH");

		Object[] bind = new Object[] {
				p_box.get("evaym").replaceAll("-", ""),
				p_box.get("ENO_NO")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	public GauceDataSet VLUL010_SHR_SUB(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SHR_SUB");

		//System.out.println("p_box=========="+p_box);
		StringBuffer sb = new StringBuffer();

		if(p_box.get("SUBMIT_SHR").equals("Y")){
			sb.append("AND B.EVAYM =A.EVAYM AND B.EMPNO=A.EMPNO   \n");
		}else{
			sb.append("AND B.EVAYM =A.EVAYM(+) AND B.EMPNO=A.EMPNO(+) \n");			
		}
		
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);		
		
		Object[] bind = new Object[] {
		
		};

		return this.selectProcess(sql, bind, prop);
	}	

	public void VLUL010_SAV_MST(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SAV_MST");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),
				JSPUtil.rns(vo.get("HEADCD")),
				JSPUtil.rns(vo.get("DIVCD")),
				JSPUtil.rns(vo.get("DEPTCD")),
				JSPUtil.rns(vo.get("PAYGRD")),
				JSPUtil.rns(vo.get("WORK_1")),
				JSPUtil.rns(vo.get("STARTDT_1")),
				JSPUtil.rns(vo.get("ENDDT_1")),
				JSPUtil.rns(vo.get("PLACE_1")),
				JSPUtil.rns(vo.get("REMARK_1")),
				JSPUtil.rns(vo.get("WORK_2")),
				JSPUtil.rns(vo.get("STARTDT_2")),
				JSPUtil.rns(vo.get("ENDDT_2")),
				JSPUtil.rns(vo.get("PLACE_2")),
				JSPUtil.rns(vo.get("REMARK_2")),
				JSPUtil.rns(vo.get("WORK_3")),
				JSPUtil.rns(vo.get("STARTDT_3")),
				JSPUtil.rns(vo.get("ENDDT_3")),
				JSPUtil.rns(vo.get("PLACE_3")),
				JSPUtil.rns(vo.get("REMARK_3")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}


	public void VLUL010_UPT_MST(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_UPT_MST");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("HEADCD")),
				JSPUtil.rns(vo.get("DIVCD")),
				JSPUtil.rns(vo.get("DEPTCD")),
				JSPUtil.rns(vo.get("PAYGRD")),
				JSPUtil.rns(vo.get("WORK_1")),
				JSPUtil.rns(vo.get("STARTDT_1")),
				JSPUtil.rns(vo.get("ENDDT_1")),
				JSPUtil.rns(vo.get("PLACE_1")),
				JSPUtil.rns(vo.get("REMARK_1")),
				JSPUtil.rns(vo.get("WORK_2")),
				JSPUtil.rns(vo.get("STARTDT_2")),
				JSPUtil.rns(vo.get("ENDDT_2")),
				JSPUtil.rns(vo.get("PLACE_2")),
				JSPUtil.rns(vo.get("REMARK_2")),
				JSPUtil.rns(vo.get("WORK_3")),
				JSPUtil.rns(vo.get("STARTDT_3")),
				JSPUtil.rns(vo.get("ENDDT_3")),
				JSPUtil.rns(vo.get("PLACE_3")),
				JSPUtil.rns(vo.get("REMARK_3")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


	public void VLUL010_SAV_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_SAV_DTL");

		//System.out.println("vo==="+vo);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),
				JSPUtil.rns(vo.get("SEQ2")),
				JSPUtil.rns(vo.get("WORKGB")),
				JSPUtil.rns(vo.get("WKCONT")),
				JSPUtil.rns(vo.get("IMPORT")),
				JSPUtil.rns(vo.get("SCORE")),
				JSPUtil.rns(vo.get("CH_SCORE")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	public void VLUL010_UPT_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_UPT_DTL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("WORKGB")),
				JSPUtil.rns(vo.get("WKCONT")),
				JSPUtil.rns(vo.get("IMPORT")),
				JSPUtil.rns(vo.get("SCORE")),
				JSPUtil.rns(vo.get("CH_SCORE")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),
				JSPUtil.rns(vo.get("SEQ2")),
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

		
	public void VLUL010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	
	public void VLUL010_DEL_DTL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUL010_DEL_DTL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("EVAYM")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("EMPNO")),
				JSPUtil.rns(vo.get("SEQ2")),
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
}
