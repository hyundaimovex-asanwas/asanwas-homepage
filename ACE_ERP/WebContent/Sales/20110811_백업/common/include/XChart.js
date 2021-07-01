/*

XChart�� �ʱ�ȭ(XChart�� ���� ������Ƽ ������ �Ѵ�.)

����
 oXChart : �ʱ�ȭ �ϰ����ϴ� XChart

*/

function cfInitXChart1(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 10;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�

	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 0;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 100;
	oXChart.Legend.Alignment = 2;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 0;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

/*
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 150;
	oXChart.Legend.Alignment = 2;	//������ ��ġ
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 1;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");
	oXChart.Legend.FontSeriesColor = true;
*/
/*
		oXChart.Legend.Visible = 1;
		oXChart.Legend.Symbol.Width = 100;
		oXChart.Legend.Alignment = 2;
		oXChart.Legend.Font.Size = 9;
		oXChart.Legend.ShadowSize = 0;
   oXChart.Legend.Frame.Visible = true;
*/

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 5;
}

function cfInitXChart2(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 15;
}

function cfInitXChart3(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 10;
}

function cfInitXChart12(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 13;
}

function cfInitXChart33(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 13;

	// �� ���� title
	oXChart.Axis.Left.Title.Visible = true;
	oXChart.Axis.Left.Title.Caption = "(���� :  ��)";
	oXChart.Axis.Bottom.Title.Caption = "(���� : ������)";

}

function cfInitXChart4(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 13;

	// �� ���� title
	oXChart.Axis.Left.Title.Visible = true;
	oXChart.Axis.Left.Title.Caption = "(���� :  ��)";
	oXChart.Axis.Bottom.Title.Caption = "(���� : õ����Ʈ)";

}

function cfInitXChart13(oXChart) {
	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 20;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=9;
	oXChart.Header.Text.Add ('�μ��� ��Ȳ');

	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = true;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = false;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 //oXChart.Page.MaxPointsPerPage = 15;
	 oXChart.Page.MaxPointsPerPage = 40;

}

function cfInitXChart14(oXChart) {

	//���� ������ Series���� Ŭ���� �Ѵ�
	oXChart.RemoveAllSeries();

	//XChart�� ����,������� �Ӽ��� �����Ѵ�
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart�� Ÿ��Ʋ�� ���õ� �Ӽ��� �����Ѵ�
  //���� : XChart���� Title�Ӽ��� ���� ��� Header�Ӽ��� �����Ѵ�
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=9;
	oXChart.Header.Text.Add ('������ ��Ȳ');
	
	//XChart�� �ǳ��� �Ӽ��� �����Ѵ�
	//XChart�� ǥ�õǴ� ��ü������ ������ �����ϴ°��̴�
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart�� ��ǥ�࿡ ���õ� �Ӽ��� �����Ѵ�

	//XChart�� ������ ���� ���� �����Ѵ�
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//���� ��Ÿ���� ���� ���� �����Ѵ�
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//�࿡ ǥ�õǴ� ��ǥ���� ���� �����Ѵ�
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend�� �Ӽ��� �����Ѵ�
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//����(���콺�� Series���� �÷����� ���� ���� �ֱ����� ����
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//�� page�� ���� Point���� �����Ѵ�.
	 oXChart.Page.MaxPointsPerPage = 2;
}

/*

���� Series�� �ϳ��� �߰�

����
	oXChart : �߰��ϰ��� �ϴ� XChart Object
	oDataSet : XChart�� �����ϴ� DataID, �� ����Ÿ��
	vType : Series�� ������ �����Ѵ�
	vTitle : Legend�� ǥ�õǴ� �̸�
	vLable : X�࿡ ǥ�õǴ� �̸�
	vYvalue : ��Ʈ�� �����Ǵ� ������ ��
	vColor : �ش� Series�� �����ϴ� ����

*/

function cfInitXChart15(XChart) {

	//Chart 3d�� ǥ������ ����
	XChart.Aspect.View3D="true";
	
	//Chart ������ borderstyle
	XChart.Panel.Color = XChart.ToOLEColor("white");
	XChart.Panel.BorderStyle = 0;
	
	//Header����
	XChart.Header.Font.Color = XChart.ToOLEColor("BLUE");
	XChart.Header.Text.Clear();
	XChart.Header.Text.Add ("������ ��Ȳ");
	XChart.Header.Alignment = 2;

	//legend����
	XChart.Legend.ShadowSize = 0;
	XChart.Legend.Frame.Visible = false;
	XChart.Legend.TopPos = 45;
	XChart.Legend.Alignment = 2;
	XChart.Legend.Symbol.WidthUnits = 1;
	XChart.Legend.Symbol.Width = 20;

	//Grid����.
	//XChart.Axis.Bottom.GridPen.visible = false;
	//XChart.Axis.Left.GridPen.visible = false;
	XChart.Axis.Left.Labels.Font.Color   = XChart.ToOLEColor("BLUE");

	//MarkTip ���� (���콺 click�Ͽ� ���� Ȯ���� �� �ִ�.)
	Mark = XChart.Tools.Add (8);
	
	XChart.Tools.Items(Mark).asMarksTip.Series = "0"; // Uses Seriesindex
	XChart.Tools.Items(Mark).asMarksTip.style = 0;
	XChart.Tools.Items(Mark).asMarksTip.MouseAction = 0;  //0:mouse over, 1:mouse click
	XChart.Tools.Items(Mark).asMarksTip.Delay = 0;
	
	XChart.Zoom.Pen.Color = XChart.ToOLEColor("#1D5B89");
}


function cfAddSeriesOne_1(oXChart,nDataSet,vType,vTitle,vColor,cLabel,cYvalue) {

	if ((vTitle == null)||(vTitle == "undefined")) return;

	//Series�� �߰��Ѵ�
	var idx = oXChart.AddSeries(vType);

	//oXChart.Axis.Bottom.Labels.Angle = -45;
	oXChart.Axis.Bottom.Labels.MultiLine = true;

    oXChart.Series(idx).ShowInLegend = false;

	//Series�� ������ ������� �ִ� �Ӽ����̴�
	oXChart.Series(idx).DataID = nDataSet;
	oXChart.Series(idx).Title = vTitle;
	oXChart.Series(idx).LabelColumn = cLabel;
	oXChart.Series(idx).color = oXChart.ToOLEColor(vColor);
	oXChart.Series(idx).YValueColumn = cYvalue;
	oXChart.Series(idx).Marks.visible = true;

	//������ ����׷����� ���� �޸� �ִ� �Ӽ�.
	oXChart.Series(idx).ColorEachPoint = true;
//	oXChart.Series(idx).ColorEachPoint = true;
	//������ ����׷������� ����Ÿ���� ������ �ϴ� �Ӽ�.
	oXChart.Series(idx).Marks.Style =0;


	//Series�� �������� �ٸ� �Ӽ����� �ش�

		if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
		}

/*
	if (vType == 0) {
		oXChart.Series(idx).VerticalAxis = 1;
		oXChart.Series(idx).asLine.Stacked = 1;
		oXChart.Series(idx).Depth = 5;
	}

  else if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
  }
*/
  oXChart.reset();

}

function cfAddSeriesOne_2(oXChart,nDataSet,vType,vTitle,vColor,cLabel,cYvalue) {

	if ((vTitle == null)||(vTitle == "undefined")) return;

	oXChart.RemoveAllSeries();
	//Series�� �߰��Ѵ�
	var idx = oXChart.AddSeries(vType);

	//oXChart.Axis.Bottom.Labels.Angle = -45;
	oXChart.Axis.Bottom.Labels.MultiLine = true;

    oXChart.Series(idx).ShowInLegend = false;

	//Series�� ������ ������� �ִ� �Ӽ����̴�
	oXChart.Series(idx).DataID = nDataSet;
	oXChart.Series(idx).Title = vTitle;
	oXChart.Series(idx).LabelColumn = cLabel;
	oXChart.Series(idx).color = oXChart.ToOLEColor(vColor);
	oXChart.Series(idx).YValueColumn = cYvalue;
	oXChart.Series(idx).Marks.visible = true;


	//������ ����׷����� ���� �޸� �ִ� �Ӽ�.
	oXChart.Series(idx).ColorEachPoint = true;
//	oXChart.Series(idx).ColorEachPoint = true;
	//������ ����׷������� ����Ÿ���� ������ �ϴ� �Ӽ�.
	oXChart.Series(idx).Marks.Style =1;

	//Series�� �������� �ٸ� �Ӽ����� �ش�
	if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
	}

  oXChart.reset();

}

