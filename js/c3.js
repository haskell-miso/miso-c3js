globalThis.initChart = function (canvas) {
  return c3.generate({
    bindto: canvas,
    data: {
      columns: [
        [
          "Product A",
          12000,
          15000,
          18000,
          22000,
          19000,
          25000,
          28000,
          30000,
          27000,
          32000,
          35000,
          38000,
        ],
        [
          "Product B",
          8000,
          12000,
          10000,
          15000,
          18000,
          16000,
          20000,
          22000,
          25000,
          28000,
          30000,
          32000,
        ],
        [
          "Product C",
          5000,
          7000,
          9000,
          11000,
          13000,
          15000,
          14000,
          16000,
          18000,
          20000,
          22000,
          24000,
        ],
      ],
      type: "bar",
      colors: {
        "Product A": "#4c51bf",
        "Product B": "#38b2ac",
        "Product C": "#ed8936",
      },
      groups: [["Product A", "Product B", "Product C"]],
    },
    bar: {
      width: {
        ratio: 0.6,
      },
    },
    axis: {
      x: {
        type: "category",
        categories: [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ],
        tick: {
          rotate: 0,
          multiline: false,
        },
      },
      y: {
        label: {
          text: "Revenue ($)",
          position: "outer-middle",
        },
        tick: {
          format: d3.format("$,"),
        },
      },
    },
    grid: {
      y: {
        show: true,
      },
    },
    tooltip: {
      format: {
        title: function (d) {
          return (
            "Month: " +
            [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
              "August",
              "September",
              "October",
              "November",
              "December",
            ][d]
          );
        },
        value: function (value, ratio, id) {
          return "$" + value.toLocaleString();
        },
      },
    },
    legend: {
      position: "bottom",
    },
    padding: {
      right: 20,
    },
  });
};
