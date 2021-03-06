jui.define("chart.grid.block", [ "util.scale", "util.base" ], function(UtilScale, _) {

	/**
	 * @class chart.grid.block
	 * Implements Block Grid
	 *
	 *  { type : "block", domain : [ 'week1', 'week2', 'week3' ] }
	 *
	 * @extends chart.grid.core
	 */
	var BlockGrid = function() {
		this.center = function(g) {
			this.drawCenter(g, this.domain, this.points, null, this.half_band);
			this.drawBaseLine("center", g);
		}

		this.top = function(g) {
			this.drawPattern("top", this.domain, this.points, true);
			this.drawTop(g, this.domain, this.points, null, this.half_band);
			this.drawBaseLine("top", g);
			g.append(this.createGridX("top", this.domain.length, this.end, null, true));
		}

		this.bottom = function(g) {
			this.drawPattern("bottom", this.domain, this.points, true);
			this.drawBottom(g, this.domain, this.points, null, this.half_band);
			this.drawBaseLine("bottom", g);
			g.append(this.createGridX("bottom", this.domain.length, this.end, null, true));
		}

		this.left = function(g) {
			this.drawPattern("left", this.domain, this.points, true);
			this.drawLeft(g, this.domain, this.points, null, this.half_band);
			this.drawBaseLine("left", g);
			g.append(this.createGridY("left", this.domain.length, this.end, null, true));
		}

		this.right = function(g) {
			this.drawPattern("right", this.domain, this.points, true);
			this.drawRight(g, this.domain, this.points, null, this.half_band);
			this.drawBaseLine("right", g);
			g.append(this.createGridY("right", this.domain.length, this.end, null, true));
		}

		this.initDomain = function() {
			var domain = [];

			if (_.typeCheck("string", this.grid.domain)) {
				var field = this.grid.domain;
				var data = this.data();

				if (this.grid.reverse) {
					var start = data.length - 1,
						end = 0,
						step = -1;
				} else {
					var start = 0,
						end = data.length - 1,
						step = 1;
				}

				for (var i = start; ((this.grid.reverse) ? i >= end : i <=end); i += step) {
					domain.push(data[i][field]);
				}

			} else if (_.typeCheck("function", this.grid.domain)) {	// block ??? ????????? ????????? ?????????
				domain = this.grid.domain.call(this.chart);
			} else if (_.typeCheck("array", this.grid.domain)) {
				domain = this.grid.domain;
			}

			if (this.grid.reverse) {
				domain.reverse();
			}

			return domain;
		}

		this.wrapper = function(scale, key) {
			var old_scale = scale;
			var self = this;
			var len = self.domain.length;
			var reverse = self.grid.reverse;

			function new_scale(i) {
				if (typeof i == 'number' && key) {
					return old_scale(self.axis.data[i][key]);
				} else {
					return old_scale(reverse ? len - i - 1 : i);
				}

			}

			return (key) ? _.extend(new_scale, old_scale) : old_scale;
		}

		this.drawBefore = function() {
			var domain = this.initDomain(),
				obj = this.getGridSize(),
				range = [ obj.start, obj.end ];

			// scale ??????
			this.scale = UtilScale.ordinal().domain(domain);
			this.scale.rangePoints(range);

			this.start = obj.start;
			this.size = obj.size;
			this.end = obj.end;
			this.points = this.scale.range();
			this.domain = this.scale.domain();

			this.band = this.scale.rangeBand();
			this.half_band = this.band/2;
			this.bar = 6;
			this.reverse = this.grid.reverse;
		}

		this.draw = function() {
			return this.drawGrid("block");
		}
	}


	BlockGrid.setup = function() {
		return {
			/** @cfg {String/Array/Function} [domain=null] Sets the value displayed on an axis.*/
			domain: null,
			/** @cfg {Boolean} [reverse=false] Reverses the value on domain values*/
			reverse: false,
			/** @cfg {Number} [max=10] Sets the maximum value of a grid. */
			max: 10,
			/** @cfg {Boolean} [hideText=false] Determines whether to show text across the grid. */
			hideText: false,
			/** @cfg {String} [key=null] Sets the value on the grid to the value for the specified key. */
			key: null
		};
	}

	return BlockGrid;
}, "chart.grid.core");