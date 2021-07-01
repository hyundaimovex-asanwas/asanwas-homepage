package Ehr.vlu.k.vluk020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class VLUK020DAO extends AbstractDAO {
	/**
	 * VLUK020DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void VLUK020_SHR(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GB_MST"));

		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/


		StringBuffer sb = new StringBuffer();

		/** ��ȸ ���ǿ� ���� ó�� **/
		if( ! GBMST_STR.equals("00") ){
			sb.append("AND GB_MST = '"+GBMST_STR+"' \n");
	     }else {
	    	 sb.append("AND 1=1");
	     }

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
			};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REG_YM_SHR")).replaceAll("-", "")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
//		this.selectProcessFirstRow(sql,  null, prop);
	}

	public void VLUK020_SAV(GauceValueObject vo, CBox p_box) throws CException {

		
		//System.out.println(vo);
		//System.out.println(p_box);
		
		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SAV");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		};
		/** CREATE�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);		
		
		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
				,JSPUtil.rns(vo.get("EVAYM"))
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(p_box.get("GB_DTL" ))
		};
		/** CREATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);
	}


	public void VLUK020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))

		};
		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);
	}

	
	public void VLUK020_SHR_DPT(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GB_MST"));

		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SHR_DPT");

		Object[] bind = new Object[] {

		};

		/** FirstRow�޼ҵ� ȣ�� **/
//		this.selectProcessFirstRow(sql, bind, prop);
		this.selectProcessFirstRow(sql,  null, prop);
	}

	public void VLUK020_SAV_DPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_SAV_DPT");

		int t_scr = Integer.parseInt(vo.get("T_SCR"));		

		/*  �ٹ���  */
		double vg_scr = (double)t_scr*1;
		double g_scr = (double)t_scr*0.85;
		double n_scr = (double)t_scr*0.7;
		double b_scr = (double)t_scr*0.55;
		double vb_scr = (double)t_scr*0.4;			
		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		        
		        ,JSPUtil.rns(vo.get("T_SCR" ))		   
		        
				,Double.toString(vg_scr)                         	// ��
				,Double.toString(g_scr)                         	// ��
				,Double.toString(n_scr)                         	// ��
				,Double.toString(b_scr)                         	// ��
				,Double.toString(vb_scr)                         	// ��				        
		};
		
		
		/** CREATE�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);
		
		
		
	}

	public void VLUK020_UPT_DPT(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);		
		
		int t_scr = Integer.parseInt(vo.get("T_SCR"));		

		/*  �ٹ���  */
		double vg_scr = (double)t_scr*1;
		double g_scr = (double)t_scr*0.85;
		double n_scr = (double)t_scr*0.7;
		double b_scr = (double)t_scr*0.55;
		double vb_scr = (double)t_scr*0.4;				
		
		
		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_UPT_DPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))
		        ,JSPUtil.rns(vo.get("T_SCR" ))		   
		        
				,Double.toString(vg_scr)                         	// ��
				,Double.toString(g_scr)                         	// ��
				,Double.toString(n_scr)                         	// ��
				,Double.toString(b_scr)                         	// ��
				,Double.toString(vb_scr)                         	// ��		
				
				,JSPUtil.rns(vo.get("EVAYM"))
		        ,JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		};
		/** CREATE�޼ҵ� ȣ��  **/
		this.updateProcess(sql, bind);
	}


	public void VLUK020_DEL_DPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK020_DEL_DPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GB_MST" ))
		        ,JSPUtil.rns(vo.get("GB_DTL" ))
		        ,JSPUtil.rns(vo.get("ACT_ITEM" ))

		};
		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);
	}
	
	
}
