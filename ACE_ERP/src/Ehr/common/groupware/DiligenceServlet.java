package common.groupware;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gauce.GauceDataSet;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.support.collection.CBox;

import common.util.JSPUtil;

import java.io.*;
import com.shift.gef.core.log.Log;
/**
 * GroupWare��û������ ���콺�� ������ �ʰ� ������ ���� ó���ϴ� ���α׷�
 * @author ������
 * @version 1.0, 2009.12.02
 * @see
 */
public class DiligenceServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException ,IOException {
		try
		{
			/*
			 * ȸ��μ��ڵ忡 �ִ� EXT_03�� ���µ�Ͻð��� ������ check
			 */

			String ENO_NO = req.getParameter("ENO_NO").substring(3);

			DiligenceDAO dao = new DiligenceDAO("default");

			CBox p_box = new CBox();
			p_box.put("ENO_NO", ENO_NO);

			// �������� üũ
			GauceDataSet ds = dao.GROUPWARE_SHR_03(p_box);
			int rowCnt = ds.getDataRowCnt();
			//System.out.println("�׷���� ���� �������� rowCnt [" + rowCnt + "]");
			System.out.print(" \n�׷���� ���� �����ȣ [" + ENO_NO + "]");
			if(rowCnt > 0){

				String EXT_03 = JSPUtil.rns(GauceUtils.nameValue(ds, 1, "EXT_03"));
				String GUN_CD = GauceUtils.nameValue(ds, 1, "GUN_CD");
				String CUR_DATE = GauceUtils.nameValue(ds, 1, "CUR_DATE");
				String DPT_CD = GauceUtils.nameValue(ds, 1, "DPT_CD");
				String GUN_YMD = GauceUtils.nameValue(ds, 1, "GUN_YMD");
				String C_YMDHM = GauceUtils.nameValue(ds, 1, "C_YMDHM");
				String S_YMDHM = GauceUtils.nameValue(ds, 1, "S_YMDHM");

				System.out.print(" / �׷���� ������   [" + GUN_YMD + "]");
				System.out.print(" / �׷���� ����ð� [" + CUR_DATE + "]");
				//System.out.println("�׷���� ���½ð� [" + EXT_03 + "]");
				//System.out.println("�׷���� ��ȹ�α��½ð� [" + S_YMDHM + "]");
				//System.out.println("�׷���� �������½ð�   [" + C_YMDHM + "]");
				//System.out.println("�׷���� ���ºμ� [" + DPT_CD + "]");
				System.out.println(" / �׷���� �����ڵ� [" + GUN_CD + "]");
				if("".equals(EXT_03)){
					System.out.print(" / ȸ��μ��ڵ忡 ���½ð��� �������� �ʽ��ϴ�");
					return;
				}
				// T_DI_DILIGENCE �� ���� ������ �� ���� �ۼ�
				dao.GROUPWARE_INS_01(p_box, GUN_YMD, DPT_CD);
				// �������Ͽ� Y �� ����
				dao.GROUPWARE_UPT_01(GUN_YMD, p_box);
				// T_DI_DILIGENCE�� �����ڵ尪 ����
				dao.GROUPWARE_UPT_01(GUN_YMD, ENO_NO, GUN_CD, p_box);
				// T_DI_DILIGENCE�� �����Ѱ谪 ����
				dao.GROUPWARE_UPT_02(GUN_YMD, ENO_NO, p_box);
			}else{

			}

		} catch (Exception e) {
			System.out.println("DiligenceServlet ........ Error !!");
			e.printStackTrace();
		}
	}
    public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {

		doGet(req,res);
   }
}
