import 'package:flutter/material.dart';


class Stop {
  String address = "";
  double latitude = 0;
  double longitude = 0;
  int wheelchair_boarding = -1;
  String id = "";
  String name = "";

  Stop(String _address, double _latitude, double _longitude, int _wheelchair_boarding, String _id, String _name) {
    address  = _address;
    latitude = _latitude;
    longitude = _longitude;
    wheelchair_boarding = _wheelchair_boarding;
    id = _id;
    name = _name;
  }
}

Stop? selectedStop = null;

class SelectStop extends StatefulWidget {
  const SelectStop({super.key, required this.title});
  final String title;

  @override
  State<SelectStop> createState() => SelectStopState();
}

class SelectStopState extends State<SelectStop> {

  List<TextButton> RenderStopNames() {
    List<TextButton> textboxes = [TextButton(onPressed: () => {selectedStop = null}, child: Text("Auto Detect", style:TextStyle(color: Colors.white)))];

    for(String key in stopInfo.keys) {
      Stop value = stopInfo[key]!;
      textboxes.add(TextButton(onPressed: () => {selectedStop = stopInfo[key]}, child: Text(value.name, style:TextStyle(color: Colors.white))));

    }
    return textboxes;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold (
        appBar: AppBar(
            title: Text(
              "Select Stop",
              // style: Theme.of(context).textTheme.displayLarge,
            )
        ),


        body: Column (
            children: <Widget> [

              Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: RenderStopNames(),
                  )
              ),
            ]
        )
    );
  }
}


Map<String, Stop> stopInfo = {
  "place-CM-0493": Stop("176 Merchants Way, Wareham, MA 02571", 41.758333, -70.714722, 1, "place-CM-0493", "Wareham Village"),
  "place-CM-0547": Stop("70 Main Street, Buzzards Bay, MA 02532", 41.744805, -70.616226, 1, "place-CM-0547", "Buzzards Bay"),
  "place-CM-0564": Stop("21 Bourne Bridge, Bourne, MA 02532", 41.746497, -70.588772, 1, "place-CM-0564", "Bourne"),
  "place-CM-0790": Stop("215 Iyannough Road, Hyannis, MA 02601", 41.660225, -70.276583, 1, "place-CM-0790", "Hyannis"),
  "place-DB-0095": Stop("1800 Hyde Park Ave, Hyde Park, MA 02136", 42.238405, -71.133246, 1, "place-DB-0095", "Readville"),
  "place-DB-2205": Stop("Fairmount Ave and Truman Hwy, Hyde Park, MA 02136", 42.253638, -71.11927, 1, "place-DB-2205", "Fairmount"),
  "place-DB-2222": Stop("Blue Hill Ave or Cummins Hwy at Woodhaven St, Mattapan, MA 02126", 42.271466, -71.095782, 1, "place-DB-2222", "Blue Hill Avenue"),
  "place-DB-2230": Stop("865 Morton St, Mattapan, MA 02126", 42.280994, -71.085475, 1, "place-DB-2230", "Morton Street"),
  "place-DB-2240": Stop("210 Talbot Ave, Boston, MA 02124", 42.292246, -71.07814, 1, "place-DB-2240", "Talbot Avenue"),
  "place-DB-2249": Stop("171 Geneva Ave, Boston, MA 02121", 42.305037, -71.076833, 1, "place-DB-2249", "Four Corners/Geneva"),
  "place-DB-2258": Stop("691 Dudley St, Dorchester, MA 02125", 42.319125, -71.068627, 1, "place-DB-2258", "Uphams Corner"),
  "place-DB-2265": Stop("1070 Massachusetts Ave, Boston, MA 02118", 42.327415, -71.065674, 1, "place-DB-2265", "Newmarket"),
  "place-ER-0099": Stop("1000 Western Ave, Lynn, MA 01910 (General Electric employees only)", 42.449927, -70.969848, 2, "place-ER-0099", "River Works"),
  "place-ER-0115": Stop("325 Broad St, Lynn, MA 01901", 42.462953, -70.945421, 1, "place-ER-0115", "Lynn"),
  "place-ER-0117": Stop("11 Ellis St, Lynn, MA 01902", 42.46529, -70.940434, 1, "place-ER-0117", "Lynn Interim"),
  "place-ER-0128": Stop("Burrill St and Railroad Ave, Swampscott, MA 01907", 42.473743, -70.922537, 1, "place-ER-0128", "Swampscott"),
  "place-ER-0168": Stop("252 Bridge St, Salem, MA 01970", 42.524792, -70.895876, 1, "place-ER-0168", "Salem"),
  "place-ER-0183": Stop("10 Park St, Beverly, MA 01915", 42.547276, -70.885432, 1, "place-ER-0183", "Beverly"),
  "place-ER-0208": Stop("Enon St and Dodge St, Beverly, MA 01915", 42.583779, -70.883851, 1, "place-ER-0208", "North Beverly"),
  "place-ER-0227": Stop("Bay Rd and Walnut Rd, Hamilton, MA 01982", 42.609212, -70.874801, 1, "place-ER-0227", "Hamilton/Wenham"),
  "place-ER-0276": Stop("4 Peatfield St, Ipswich, MA 01938", 42.676921, -70.840589, 1, "place-ER-0276", "Ipswich"),
  "place-ER-0312": Stop("70 Railroad Ave, Rowley, MA 01969", 42.726845, -70.859034, 1, "place-ER-0312", "Rowley"),
  "place-ER-0362": Stop("25 Boston Way, Newburyport, MA 01950", 42.797837, -70.87797, 1, "place-ER-0362", "Newburyport"),
  "place-FB-0109": Stop("186 Grant Ave, Dedham, MA 02026", 42.233249, -71.158647, 2, "place-FB-0109", "Endicott"),
  "place-FB-0118": Stop("125 Allied Dr, Dedham, MA 02026", 42.227079, -71.174254, 1, "place-FB-0118", "Dedham Corporate Center"),
  "place-FB-0125": Stop("48 Carroll Ave, Westwood, MA 02090", 42.22105, -71.183961, 2, "place-FB-0125", "Islington"),
  "place-FB-0143": Stop("14 Hill St, Norwood, MA 02062", 42.196857, -71.196688, 1, "place-FB-0143", "Norwood Depot"),
  "place-FB-0148": Stop("164 Broadway, Norwood, MA 02062", 42.188775, -71.199665, 1, "place-FB-0148", "Norwood Central"),
  "place-FB-0166": Stop("Buckminster Dr and Engamore Ln, Norwood, MA 02062", 42.172127, -71.219366, 2, "place-FB-0166", "Windsor Gardens"),
  "place-FB-0177": Stop("185 Plimpton St, Walpole, MA 02081", 42.159123, -71.236125, 2, "place-FB-0177", "Plimptonville"),
  "place-FB-0191": Stop("275 West St, Walpole, MA 02081", 42.145477, -71.25779, 2, "place-FB-0191", "Walpole"),
  "place-FB-0230": Stop("9 Rockwood Rd, Norfolk, MA 02056", 42.120694, -71.325217, 1, "place-FB-0230", "Norfolk"),
  "place-FB-0275": Stop("75 Depot St, Franklin, MA 02038", 42.083238, -71.396102, 2, "place-FB-0275", "Franklin"),
  "place-FB-0303": Stop("1000 W Central St, Franklin, MA 02038", 42.089941, -71.43902, 1, "place-FB-0303", "Forge Park/495"),
  "place-FR-0064": Stop("Common St and Concord Ave, Belmont, MA 02478", 42.395896, -71.17619, 2, "place-FR-0064", "Belmont"),
  "place-FR-0074": Stop("525 Trapelo Rd, Belmont, MA 02478", 42.3876, -71.190744, 2, "place-FR-0074", "Waverley"),
  "place-FR-0098": Stop("75 Carter St, Waltham, MA 02453", 42.374296, -71.235615, 1, "place-FR-0098", "Waltham"),
  "place-FR-0115": Stop("1 Sawyer Rd, Waltham, MA 02453", 42.361898, -71.260065, 1, "place-FR-0115", "Brandeis/Roberts"),
  "place-FR-0132": Stop("198 Church St, Weston, MA", 42.37897, -71.282411, 2, "place-FR-0132", "Kendal Green"),
  "place-FR-0137": Stop("105 Viles St, Weston, MA 02493", 42.385755, -71.289203, 2, "place-FR-0137", "Hastings"),
  "place-FR-0147": Stop("Silver Hill Rd and Merriam St, Weston, MA 02493", 42.395625, -71.302357, 2, "place-FR-0147", "Silver Hill"),
  "place-FR-0167": Stop("160 Lincoln Rd, Lincoln, MA 01773", 42.413641, -71.325512, 2, "place-FR-0167", "Lincoln"),
  "place-FR-0201": Stop("90 Thoreau St, Concord, MA 01742", 42.456565, -71.357677, 2, "place-FR-0201", "Concord"),
  "place-FR-0219": Stop("Commonwealth Ave and Main St, West Concord, MA 01742", 42.457043, -71.392892, 1, "place-FR-0219", "West Concord"),
  "place-FR-0253": Stop("4 Central St, Acton, MA 01720", 42.460375, -71.457744, 1, "place-FR-0253", "South Acton"),
  "place-FR-0301": Stop("Grimes Ln and Foster St, Littleton, MA 01460", 42.519236, -71.502643, 1, "place-FR-0301", "Littleton/Route 495"),
  "place-FR-0361": Stop("70 Main St, Ayer, MA 01432", 42.559074, -71.588476, 2, "place-FR-0361", "Ayer"),
  "place-FR-0394": Stop("Ayer Rd and Phoenix St, Shirley, MA 01464", 42.545089, -71.648004, 2, "place-FR-0394", "Shirley"),
  "place-FR-0451": Stop("44 Nashua St, Leominster, MA 01453", 42.539017, -71.739186, 1, "place-FR-0451", "North Leominster"),
  "place-FR-0494": Stop("150 Main St, Fitchburg, MA 01420", 42.58072, -71.792611, 1, "place-FR-0494", "Fitchburg"),
  "place-FR-3338": Stop("55 Authority Dr, Fitchburg, MA 01420", 42.553477, -71.848488, 1, "place-FR-3338", "Wachusett"),
  "place-FS-0049": Stop("Gillette Stadium near Lots 3 and 4, Foxborough, MA 02035", 42.0951, -71.26151, 1, "place-FS-0049", "Foxboro"),
  "place-GB-0198": Stop("180 Essex St, Beverly, MA 01915", 42.562171, -70.869254, 1, "place-GB-0198", "Montserrat"),
  "place-GB-0222": Stop("600 Hale St, Beverly, MA 01915", 42.559446, -70.825541, 2, "place-GB-0222", "Prides Crossing"),
  "place-GB-0229": Stop("1 Oak St, Beverly, MA 01915", 42.561651, -70.811405, 1, "place-GB-0229", "Beverly Farms"),
  "place-GB-0254": Stop("40 Beach St, Manchester, MA 01944", 42.573687, -70.77009, 1, "place-GB-0254", "Manchester"),
  "place-GB-0296": Stop("290 Essex Ave, Gloucester, MA 01930", 42.611933, -70.705417, 1, "place-GB-0296", "West Gloucester"),
  "place-GB-0316": Stop("75 Railroad Ave, Gloucester, MA 01930", 42.616799, -70.668345, 1, "place-GB-0316", "Gloucester"),
  "place-GB-0353": Stop("17 Railroad Ave, Rockport, MA 01966", 42.655491, -70.627055, 1, "place-GB-0353", "Rockport"),
  "place-GRB-0118": Stop("121 Commercial St, Weymouth, MA 02184", 42.221503, -70.968152, 1, "place-GRB-0118", "Weymouth Landing/East Braintree"),
  "place-GRB-0146": Stop("1590 Commercial St, East Weymouth, MA 02189", 42.2191, -70.9214, 1, "place-GRB-0146", "East Weymouth"),
  "place-GRB-0162": Stop("20 Fort Hill Rd, Hingham, MA 02043", 42.235838, -70.902708, 1, "place-GRB-0162", "West Hingham"),
  "place-GRB-0183": Stop("190 Summer St, Hingham, MA 02043", 42.244959, -70.869205, 1, "place-GRB-0183", "Nantasket Junction"),
  "place-GRB-0199": Stop("110 Chief Justice Cushing Hwy, Cohasset, MA 02025", 42.24421, -70.837529, 1, "place-GRB-0199", "Cohasset"),
  "place-GRB-0233": Stop("777 Country Way, Scituate, MA 02066", 42.219528, -70.788602, 1, "place-GRB-0233", "North Scituate"),
  "place-GRB-0276": Stop("247 Old Driftway, Scituate, MA 02066", 42.178776, -70.746641, 1, "place-GRB-0276", "Greenbush"),
  "place-KB-0351": Stop("134 Marion Dr, Kingston, MA 02364", 41.97762, -70.721709, 1, "place-KB-0351", "Kingston"),
  "place-MM-0150": Stop("Union St and Center St, Randolph, MA 02368", 42.156343, -71.027371, 1, "place-MM-0150", "Holbrook/Randolph"),
  "place-MM-0186": Stop("150 Spark St, Brockton, MA 02302", 42.106555, -71.022001, 1, "place-MM-0186", "Montello"),
  "place-MM-0200": Stop("7 Commercial St, Brockton, MA 02302", 42.084659, -71.016534, 1, "place-MM-0200", "Brockton"),
  "place-MM-0219": Stop("30 Riverside Ave, Brockton, MA 02301", 42.060951, -71.011004, 1, "place-MM-0219", "Campello"),
  "place-MM-0277": Stop("85 Burrill Ave, Bridgewater, MA 02324", 41.984916, -70.96537, 1, "place-MM-0277", "Bridgewater"),
  "place-MM-0356": Stop("125 Commercial Dr, Lakeville, MA 02347", 41.87821, -70.918444, 1, "place-MM-0356", "Middleborough/Lakeville"),
  "place-NB-0064": Stop("1 Belgrade Ave, Roslindale, MA 02131", 42.287442, -71.130283, 1, "place-NB-0064", "Roslindale Village"),
  "place-NB-0072": Stop("35 Colbert St, West Roxbury, MA 02132", 42.286588, -71.145557, 1, "place-NB-0072", "Bellevue"),
  "place-NB-0076": Stop("Corey St and Hastings St, West Roxbury, MA 02132", 42.284969, -71.153937, 1, "place-NB-0076", "Highland"),
  "place-NB-0080": Stop("450 Lagrange St, West Roxbury, MA 02132", 42.281358, -71.160065, 1, "place-NB-0080", "West Roxbury"),
  "place-NB-0109": Stop("Great Plain Ave and Broad Meadow Rd, Needham, MA 02492", 42.275648, -71.215528, 1, "place-NB-0109", "Hersey"),
  "place-NB-0120": Stop("51 Junction St, Needham, MA 02492", 42.273187, -71.235559, 1, "place-NB-0120", "Needham Junction"),
  "place-NB-0127": Stop("Great Plain Ave and Eaton Sq, Needham, MA 02492", 42.280775, -71.237686, 1, "place-NB-0127", "Needham Center"),
  "place-NB-0137": Stop("95 Avery Sq, Needham, MA 02494", 42.293444, -71.236027, 1, "place-NB-0137", "Needham Heights"),
  "place-NEC-1659": Stop("1011 Ten Rod Rd, North Kingstown, RI", 41.581289, -71.491147, 1, "place-NEC-1659", "Wickford Junction"),
  "place-NEC-1768": Stop("700 Jefferson Blvd, Warwick, RI 02886", 41.726599, -71.442453, 1, "place-NEC-1768", "TF Green Airport"),
  "place-NEC-1851": Stop("100 Gaspee St, Providence, RI 02903", 41.829293, -71.413301, 1, "place-NEC-1851", "Providence"),
  "place-NEC-1891": Stop("300 Pine St, Pawtucket, RI 02860", 41.878762, -71.392, 1, "place-NEC-1891", "Pawtucket/Central Falls"),
  "place-NEC-1919": Stop("1315 Newport Ave, Attleboro, MA 02703", 41.897943, -71.354621, 1, "place-NEC-1919", "South Attleboro"),
  "place-NEC-1969": Stop("133 South Main St, Attleboro, MA 02703", 41.940739, -71.285094, 1, "place-NEC-1969", "Attleboro"),
  "place-NEC-2040": Stop("1 Crocker St, Mansfield, MA 02048", 42.032787, -71.219917, 1, "place-NEC-2040", "Mansfield"),
  "place-NEC-2108": Stop("1 Upland Rd, Sharon, MA 02067", 42.124553, -71.184468, 1, "place-NEC-2108", "Sharon"),
  "place-NEC-2139": Stop("Beaumont St and Sherman St, Canton, MA 02021", 42.163204, -71.15376, 1, "place-NEC-2139", "Canton Junction"),
  "place-NEC-2173": Stop("50 University Ave, Westwood, MA 02090", 42.210308, -71.147134, 1, "place-NEC-2173", "Route 128"),
  "place-NEC-2203": Stop("1 Pingree St, Hyde Park, MA 02136", 42.25503, -71.125526, 1, "place-NEC-2203", "Hyde Park"),
  "place-NHRML-0055": Stop("481 High St, Medford, MA 02155", 42.421776, -71.133342, 2, "place-NHRML-0055", "West Medford"),
  "place-NHRML-0073": Stop("25 Mystic Valley Pkwy, Winchester, MA 01890", 42.444948, -71.140169, 1, "place-NHRML-0073", "Wedgemere"),
  "place-NHRML-0078": Stop("29 Waterfield Rd, Winchester, MA 01890", 42.451088, -71.13783, 1, "place-NHRML-0078", "Winchester Center"),
  "place-NHRML-0116": Stop("250 Mishawum Rd, Woburn, MA 01801", 42.504402, -71.137618, 2, "place-NHRML-0116", "Mishawum"),
  "place-NHRML-0127": Stop("100 Atlantic Ave, Woburn, MA 01801", 42.516987, -71.144475, 1, "place-NHRML-0127", "Anderson/Woburn"),
  "place-NHRML-0152": Stop("405 Main St, Wilmington, MA 01887", 42.546624, -71.174334, 1, "place-NHRML-0152", "Wilmington"),
  "place-NHRML-0218": Stop("Ruggles St and Station St, North Billerica, MA 01862", 42.593248, -71.280995, 1, "place-NHRML-0218", "North Billerica"),
  "place-NHRML-0254": Stop("101 Thorndike St, Lowell, MA 01852", 42.63535, -71.314543, 1, "place-NHRML-0254", "Lowell"),
  "place-PB-0158": Stop("89 Trotter Rd, Weymouth, MA 02190", 42.155025, -70.953302, 1, "place-PB-0158", "South Weymouth"),
  "place-PB-0194": Stop("231 Centre Ave, Abington, MA 02351", 42.107156, -70.934405, 1, "place-PB-0194", "Abington"),
  "place-PB-0212": Stop("383 South Ave, Whitman, MA 02382", 42.082749, -70.923411, 1, "place-PB-0212", "Whitman"),
  "place-PB-0245": Stop("1070 Main St, Hanson, MA 02341", 42.043967, -70.882438, 1, "place-PB-0245", "Hanson"),
  "place-PB-0281": Stop("6 Garden Rd, Halifax, MA 02338", 42.014739, -70.824263, 1, "place-PB-0281", "Halifax"),
  "place-PB-0356": Stop("385 Court St, Plymouth, MA 02360", 41.981278, -70.690421, 1, "place-PB-0356", "Plymouth"),
  "place-SB-0156": Stop("710 Washington St, Canton, MA 02021", 42.157095, -71.14628, 1, "place-SB-0156", "Canton Center"),
  "place-SB-0189": Stop("45 Wyman St, Stoughton, MA 02072", 42.124084, -71.103627, 1, "place-SB-0189", "Stoughton"),
  "place-WML-0025": Stop("25 David Ortiz Dr, Boston, MA 02215", 42.347581, -71.099974, 1, "place-WML-0025", "Lansdowne"),
  "place-WML-0035": Stop("100 Arthur St, Boston, MA 02134", 42.357293, -71.139883, 1, "place-WML-0035", "Boston Landing"),
  "place-WML-0081": Stop("770 Washington St, Newton, MA 02460", 42.351702, -71.205408, 2, "place-WML-0081", "Newtonville"),
  "place-WML-0091": Stop("1395 Washington St, Newton, MA 02465", 42.347878, -71.230528, 2, "place-WML-0091", "West Newton"),
  "place-WML-0102": Stop("Auburn St and Woodland Rd, Newton, MA 02466", 42.345833, -71.250373, 2, "place-WML-0102", "Auburndale"),
  "place-WML-0125": Stop("90 Croton St, Wellesley, MA 02481", 42.323608, -71.272288, 2, "place-WML-0125", "Wellesley Farms"),
  "place-WML-0135": Stop("341 Washington St, Wellesley, MA 02481", 42.31037, -71.277044, 2, "place-WML-0135", "Wellesley Hills"),
  "place-WML-0147": Stop("1 Grove St, Wellesley, MA 02482", 42.297526, -71.294173, 2, "place-WML-0147", "Wellesley Square"),
  "place-WML-0177": Stop("1 Walnut St, Natick, MA 01760", 42.285719, -71.347133, 2, "place-WML-0177", "Natick Center"),
  "place-WML-0199": Stop("249 West Central St, Natick, MA 01760", 42.283064, -71.391797, 1, "place-WML-0199", "West Natick"),
  "place-WML-0214": Stop("417 Waverly St, Framingham, MA 01702", 42.276108, -71.420055, 1, "place-WML-0214", "Framingham"),
  "place-WML-0252": Stop("Pleasant St and Cordaville Rd, Ashland, MA 01721", 42.26149, -71.482161, 1, "place-WML-0252", "Ashland"),
  "place-WML-0274": Stop("87 Southville Rd, Southborough, MA 01772", 42.267024, -71.524371, 1, "place-WML-0274", "Southborough"),
  "place-WML-0340": Stop("Smith Pkwy and Fisher St, Westborough, MA 01581", 42.269644, -71.647076, 1, "place-WML-0340", "Westborough"),
  "place-WML-0364": Stop("1 Pine St, North Grafton, MA 01536-1856", 42.2466, -71.685325, 1, "place-WML-0364", "Grafton"),
  "place-WML-0442": Stop("2 Washington Sq, Worcester, MA 01608", 42.261835, -71.791806, 1, "place-WML-0442", "Worcester"),
  "place-WR-0062": Stop("40 West Wyoming Ave, Melrose, MA 02176", 42.451731, -71.069379, 2, "place-WR-0062", "Wyoming Hill"),
  "place-WR-0067": Stop("Cedar Park and West Emerson St, Melrose, MA 02176", 42.458768, -71.069789, 2, "place-WR-0067", "Melrose/Cedar Park"),
  "place-WR-0075": Stop("497 Franklin St, Melrose, MA 02176", 42.469464, -71.068297, 1, "place-WR-0075", "Melrose Highlands"),
  "place-WR-0085": Stop("907 Main St, Wakefield, MA 01880", 42.483005, -71.067247, 2, "place-WR-0085", "Greenwood"),
  "place-WR-0099": Stop("225 North Ave, Wakefield, MA 01880", 42.502126, -71.075566, 2, "place-WR-0099", "Wakefield"),
  "place-WR-0120": Stop("35 Lincoln St, Reading, MA 01867", 42.52221, -71.108294, 1, "place-WR-0120", "Reading"),
  "place-WR-0163": Stop("370 Middlesex Ave, Wilmington, MA 01887", 42.569661, -71.159696, 2, "place-WR-0163", "North Wilmington"),
  "place-WR-0205": Stop("195 Andover St, Andover, MA 01810", 42.627356, -71.159962, 1, "place-WR-0205", "Ballardvale"),
  "place-WR-0228": Stop("17 Railroad St, Andover, MA 01810", 42.658336, -71.144502, 1, "place-WR-0228", "Andover"),
  "place-WR-0264": Stop("S Union St and Merrimack St, Lawrence, MA 01843", 42.701806, -71.15198, 1, "place-WR-0264", "Lawrence"),
  "place-WR-0325": Stop("10 Railroad Ave, Bradford, MA 01835", 42.766912, -71.088411, 1, "place-WR-0325", "Bradford"),
  "place-WR-0329": Stop("1 Washington Ave, Haverhill, MA 01832", 42.773474, -71.086237, 1, "place-WR-0329", "Haverhill"),
  "place-alfcl": Stop("Alewife Brook Pkwy and Cambridge Park Dr, Cambridge, MA 02140", 42.39583, -71.141287, 1, "place-alfcl", "Alewife"),
  "place-alsgr": Stop("Allston St and Commonwealth Ave, Boston, MA 02134", 42.348701, -71.137955, 2, "place-alsgr", "Allston Street"),
  "place-amory": Stop("Commonwealth Ave and Amory St, Boston, MA 02215", 42.350992, -71.114748, 1, "place-amory", "Amory Street"),
  "place-andrw": Stop("Dorchester Ave and Southhampton St, South Boston, MA 02127", 42.330154, -71.057655, 1, "place-andrw", "Andrew"),
  "place-aport": Stop("Transportation Way and Service Rd, Boston, MA 02128", 42.374262, -71.030395, 1, "place-aport", "Airport"),
  "place-aqucl": Stop("Atlantic Ave and State St, Boston, MA 02120", 42.359784, -71.051652, 1, "place-aqucl", "Aquarium"),
  "place-armnl": Stop("Arlington St and Boylston St, Boston, MA 02116", 42.351902, -71.070893, 1, "place-armnl", "Arlington"),
  "place-asmnl": Stop("Dorchester Ave and Ashmont St, Boston, MA 02124", 42.28452, -71.063777, 1, "place-asmnl", "Ashmont"),
  "place-astao": Stop("499 Foley St, Somerville, MA 02145", 42.392811, -71.077257, 1, "place-astao", "Assembly"),
  "place-babck": Stop("Commonwealth Ave and Babcock St, Boston, MA 02215", 42.351616, -71.119924, 1, "place-babck", "Babcock Street"),
  "place-balsq": Stop("646 Boston Ave, Somerville, MA 02144", 42.399889, -71.111003, 1, "place-balsq", "Ball Square"),
  "place-bbsta": Stop("145 Dartmouth St Boston, MA 02116", 42.34735, -71.075727, 1, "place-bbsta", "Back Bay"),
  "place-bckhl": Stop("100 South Huntington Ave, Boston, MA 02130", 42.330139, -71.111313, 2, "place-bckhl", "Back of the Hill"),
  "place-bcnfd": Stop("124 Beaconsfield Rd, Brookline, MA 02445", 42.335765, -71.140455, 2, "place-bcnfd", "Beaconsfield"),
  "place-bcnwa": Stop("Beacon St and Washington St, Brookline, MA", 42.339394, -71.13533, 1, "place-bcnwa", "Washington Square"),
  "place-belsq": Stop("None", 42.395438, -71.033884, 1, "place-belsq", "Bellingham Square"),
  "place-bland": Stop("Commonwealth Ave and Blandford Mall, Boston, MA 02215", 42.349293, -71.100258, 2, "place-bland", "Blandford Street"),
  "place-bmmnl": Stop("630 Winthrop Ave, Revere, MA 02151", 42.397542, -70.992319, 1, "place-bmmnl", "Beachmont"),
  "place-bndhl": Stop("1481 Beacon St, Brookline, MA", 42.340023, -71.129082, 2, "place-bndhl", "Brandon Hall"),
  "place-bomnl": Stop("Cambridge St and New Chardon St, Boston, MA 02114", 42.361365, -71.062037, 2, "place-bomnl", "Bowdoin"),
  "place-boxdt": Stop("None", 42.394049, -71.028365, 1, "place-boxdt", "Box District"),
  "place-boyls": Stop("Boylston St and Tremont St, Boston, MA", 42.35302, -71.06459, 2, "place-boyls", "Boylston"),
  "place-brdwy": Stop("Dorchester Ave and Broadway, Boston, MA", 42.342622, -71.056967, 1, "place-brdwy", "Broadway"),
  "place-brico": Stop("Commonwealth Ave and Brighton Ave, Boston, MA 02215", 42.351967, -71.125031, 2, "place-brico", "Packard's Corner"),
  "place-brkhl": Stop("Tappan St and Cypress St, Brookline, MA 02445", 42.331316, -71.126683, 1, "place-brkhl", "Brookline Hills"),
  "place-brmnl": Stop("Huntington Ave and Francis St, Boston, MA", 42.334229, -71.104609, 1, "place-brmnl", "Brigham Circle"),
  "place-brntn": Stop("197 Ivory St, Braintree, MA 02184", 42.207854, -71.001138, 1, "place-brntn", "Braintree"),
  "place-bucen": Stop("Commonwealth Ave and Marsh Chapel, Boston, MA 02215", 42.350082, -71.106865, 1, "place-bucen", "Boston University Central"),
  "place-buest": Stop("Commonwealth Ave and Granby St, Boston, MA 02215", 42.349735, -71.103889, 1, "place-buest", "Boston University East"),
  "place-butlr": Stop("Butler St and Branchfield St, Dorchester, MA 02124", 42.272429, -71.062519, 1, "place-butlr", "Butler"),
  "place-bvmnl": Stop("31 Station St, Brookline, MA 02445", 42.332608, -71.116857, 1, "place-bvmnl", "Brookline Village"),
  "place-capst": Stop("50 Capen St, Milton, MA 02186", 42.267563, -71.087338, 1, "place-capst", "Capen Street"),
  "place-ccmnl": Stop("Austin St and Rutherford Ave, Charlestown, MA", 42.373622, -71.069533, 1, "place-ccmnl", "Community College"),
  "place-cedgr": Stop("Fellsway St and Milton St, Dorchester, MA 02124", 42.279629, -71.060394, 1, "place-cedgr", "Cedar Grove"),
  "place-cenav": Stop("23 Central Ave, Milton, MA 02186", 42.270027, -71.073444, 1, "place-cenav", "Central Avenue"),
  "place-chels": Stop("174 Everett Ave, Chelsea, MA 02150", 42.397024, -71.041314, 1, "place-chels", "Chelsea"),
  "place-chhil": Stop("Hammond St and Chestnut Hill Rd, Newton, MA 02467", 42.326753, -71.164699, 2, "place-chhil", "Chestnut Hill"),
  "place-chill": Stop("Commonwealth Ave and Chestnut Hill Ave, Boston, MA", 42.338169, -71.15316, 2, "place-chill", "Chestnut Hill Avenue"),
  "place-chmnl": Stop("Cambridge St and Charles St, Boston, MA", 42.361166, -71.070628, 1, "place-chmnl", "Charles/MGH"),
  "place-chncl": Stop("Washington St and Boylston St, Boston, MA", 42.352547, -71.062752, 1, "place-chncl", "Chinatown"),
  "place-chswk": Stop("Commonwealth Ave and Chiswick Rd, Boston, MA", 42.340805, -71.150711, 2, "place-chswk", "Chiswick Road"),
  "place-clmnl": Stop("Beacon St and Chestnut Hill Ave, Brighton, MA", 42.336142, -71.149326, 1, "place-clmnl", "Cleveland Circle"),
  "place-cntsq": Stop("Massachusetts Ave and Prospect St, Cambridge, MA 02139", 42.365486, -71.103802, 1, "place-cntsq", "Central"),
  "place-coecl": Stop("Boylston St and Dartmouth St, Boston, MA", 42.349974, -71.077447, 1, "place-coecl", "Copley"),
  "place-conrd": Stop("None", 42.347154, -71.038385, 1, "place-conrd", "Silver Line Way"),
  "place-cool": Stop("Beacon St and Harvard St, Brookline, MA", 42.342116, -71.121263, 1, "place-cool", "Coolidge Corner"),
  "place-crtst": Stop("Seaport Blvd and Pittsburg St, Boston, MA", 42.35245, -71.04685, 1, "place-crtst", "Courthouse"),
  "place-davis": Stop("College Ave and Elm St, Somerville, MA", 42.39674, -71.121815, 1, "place-davis", "Davis"),
  "place-denrd": Stop("Beacon St and Dean Rd, Brookline, MA", 42.337807, -71.141853, 2, "place-denrd", "Dean Road"),
  "place-dwnxg": Stop("Washington St and Summer St, Boston, MA", 42.355518, -71.060225, 1, "place-dwnxg", "Downtown Crossing"),
  "place-eliot": Stop("248 Lincoln St, Newton, MA 02461", 42.319045, -71.216684, 2, "place-eliot", "Eliot"),
  "place-engav": Stop("Beacon St and Englewood Ave, Brookline, MA", 42.336971, -71.14566, 2, "place-engav", "Englewood Avenue"),
  "place-esomr": Stop("134 Washington St, Somerville, MA 02143", 42.379467, -71.086625, 1, "place-esomr", "East Somerville"),
  "place-estav": Stop("None", 42.388374, -71.023859, 1, "place-estav", "Eastern Avenue"),
  "place-fbkst": Stop("Beacon St and Fairbanks Ave, Brookline, MA", 42.339725, -71.131073, 2, "place-fbkst", "Fairbanks Street"),
  "place-fenwd": Stop("Huntington Ave and Fenwood Rd, Boston, MA", 42.333706, -71.105728, 2, "place-fenwd", "Fenwood Road"),
  "place-fenwy": Stop("411 Park Dr, Boston, MA 02215", 42.345403, -71.104213, 1, "place-fenwy", "Fenway"),
  "place-fldcr": Stop("50 Freeman St, Dorchester, MA 02122", 42.300093, -71.061667, 1, "place-fldcr", "Fields Corner"),
  "place-forhl": Stop("Washington St and Hyde Park Ave, Jamaica Plain, MA 02130", 42.300713, -71.113943, 1, "place-forhl", "Forest Hills"),
  "place-gilmn": Stop("161 School St, Somerville, MA 02143", 42.387928, -71.096766, 1, "place-gilmn", "Gilman Square"),
  "place-gover": Stop("Cambridge St and Court St, Boston, MA", 42.359705, -71.059215, 1, "place-gover", "Government Center"),
  "place-grigg": Stop("Commonwealth Ave and Griggs St, Boston, MA", 42.348545, -71.134949, 2, "place-grigg", "Griggs Street"),
  "place-grnst": Stop("150 Green St, Jamaica Plain, MA", 42.310525, -71.107414, 1, "place-grnst", "Green Street"),
  "place-haecl": Stop("136 Blackstone St, Boston, MA 02109", 42.363021, -71.05829, 1, "place-haecl", "Haymarket"),
  "place-harsq": Stop("1400 Massachusetts Ave, Cambridge, MA", 42.373362, -71.118956, 1, "place-harsq", "Harvard"),
  "place-harvd": Stop("Commonwealth Ave and Harvard Ave, Boston, MA", 42.350243, -71.131355, 1, "place-harvd", "Harvard Avenue"),
  "place-hsmnl": Stop("Heath St and South Huntington Ave, Boston, MA", 42.328316, -71.110252, 1, "place-hsmnl", "Heath Street"),
  "place-hwsst": Stop("Beacon St and Hawes St, Brookline, MA", 42.344906, -71.111145, 2, "place-hwsst", "Hawes Street"),
  "place-hymnl": Stop("100 Massachusetts Ave, Boston, MA", 42.347888, -71.087903, 2, "place-hymnl", "Hynes Convention Center"),
  "place-jaksn": Stop("1500 Columbus Ave, Jamaica Plain, MA", 42.323132, -71.099592, 1, "place-jaksn", "Jackson Square"),
  "place-jfk": Stop("599 Old Colony Ave, Boston, MA 02127-3805", 42.320685, -71.052391, 1, "place-jfk", "JFK/UMass"),
  "place-kencl": Stop("Commonwealth Ave and Kenmore St, Boston, MA 02215", 42.348949, -71.095169, 1, "place-kencl", "Kenmore"),
  "place-knncl": Stop("300 Main St, Cambridge, MA 02142", 42.362491, -71.086176, 1, "place-knncl", "Kendall/MIT"),
  "place-kntst": Stop("Beacon St and Powell St, Brookline, MA", 42.344074, -71.114197, 2, "place-kntst", "Kent Street"),
  "place-lake": Stop("Commonwealth Ave and Lake St, Boston, MA 02135", 42.340081, -71.166769, 1, "place-lake", "Boston College"),
  "place-lech": Stop("3 North First St, Cambridge, MA 02141", 42.371572, -71.076584, 1, "place-lech", "Lechmere"),
  "place-lngmd": Stop("Huntington Ave and Longwood Ave, Boston, MA 02115", 42.33596, -71.100052, 1, "place-lngmd", "Longwood Medical Area"),
  "place-longw": Stop("30 Chapel St, Brookline, MA 02446", 42.341702, -71.109956, 1, "place-longw", "Longwood"),
  "place-masta": Stop("393 Massachusetts Ave, Boston, MA 02118", 42.341512, -71.083423, 1, "place-masta", "Massachusetts Avenue"),
  "place-matt": Stop("500 River St, Boston, MA 02126", 42.26762, -71.092486, 1, "place-matt", "Mattapan"),
  "place-mdftf": Stop("460 Boston Ave, Medford, MA 02155", 42.407975, -71.117044, 1, "place-mdftf", "Medford/Tufts"),
  "place-mfa": Stop("Huntington Ave and Ruggles St, Boston, MA", 42.337711, -71.095512, 1, "place-mfa", "Museum of Fine Arts"),
  "place-mgngl": Stop("270 Lowell St, Somerville, MA 02145", 42.393682, -71.106388, 1, "place-mgngl", "Magoun Square"),
  "place-miltt": Stop("1 Adams St, Milton, MA 02186", 42.270349, -71.067266, 1, "place-miltt", "Milton"),
  "place-mispk": Stop("Huntington Ave and Mission Park Dr, Boston, MA 02115", 42.333195, -71.109756, 2, "place-mispk", "Mission Park"),
  "place-mlmnl": Stop("Commercial St and Pleasant St, Malden, MA 02148", 42.426632, -71.07411, 1, "place-mlmnl", "Malden Center"),
  "place-mvbcl": Stop("Sumner St and Maverick Sq, East Boston, MA", 42.369119, -71.03953, 1, "place-mvbcl", "Maverick"),
  "place-newtn": Stop("60 Station Ave, Newton, MA 02461", 42.322381, -71.205509, 1, "place-newtn", "Newton Highlands"),
  "place-newto": Stop("72 Union St, Newton, MA 02459", 42.329443, -71.192414, 1, "place-newto", "Newton Centre"),
  "place-north": Stop("135 Causeway St, Boston, MA 02114", 42.365577, -71.06129, 1, "place-north", "North Station"),
  "place-nqncy": Stop("Hancock St and Hunt St, Quincy, MA 02171", 42.275275, -71.029583, 1, "place-nqncy", "North Quincy"),
  "place-nubn": Stop("Washington St and Dudley St, Roxbury, MA", 42.329544, -71.083982, 1, "place-nubn", "Nubian"),
  "place-nuniv": Stop("Huntington Ave and Opera Pl, Boston, MA 02115", 42.340401, -71.088806, 1, "place-nuniv", "Northeastern University"),
  "place-ogmnl": Stop("Washington St and Winter St, Malden, MA 02148", 42.43668, -71.071097, 1, "place-ogmnl", "Oak Grove"),
  "place-orhte": Stop("1000 Bennington St, East Boston, MA 02128", 42.386867, -71.004736, 1, "place-orhte", "Orient Heights"),
  "place-pktrm": Stop("Tremont St and Winter St, Boston, MA 02108", 42.356395, -71.062424, 1, "place-pktrm", "Park Street"),
  "place-portr": Stop("1899 Massachusetts Ave, Cambridge, MA 02140", 42.3884, -71.119149, 1, "place-portr", "Porter"),
  "place-prmnl": Stop("Huntington Ave and Belvidere St, Boston, MA 02199", 42.34557, -71.081696, 1, "place-prmnl", "Prudential"),
  "place-qamnl": Stop("Burgin Pkwy and Centre St, Quincy, MA 02169", 42.233391, -71.007153, 1, "place-qamnl", "Quincy Adams"),
  "place-qnctr": Stop("175 Thomas E Burgin Pkwy, Quincy, MA 02169", 42.251809, -71.005409, 1, "place-qnctr", "Quincy Center"),
  "place-rbmnl": Stop("220 Shirley Ave, Revere, MA", 42.407843, -70.992533, 1, "place-rbmnl", "Revere Beach"),
  "place-rcmnl": Stop("1400 Tremont St, Roxbury, MA", 42.331397, -71.095451, 1, "place-rcmnl", "Roxbury Crossing"),
  "place-river": Stop("367 Grove St, Newton, MA 02466", 42.337352, -71.252685, 1, "place-river", "Riverside"),
  "place-rsmnl": Stop("401 Chestnut Hill Ave, Brookline, MA 02445", 42.335088, -71.148758, 1, "place-rsmnl", "Reservoir"),
  "place-rugg": Stop("1150 Tremont St, Roxbury, MA 02120", 42.336377, -71.088961, 1, "place-rugg", "Ruggles"),
  "place-rvrwy": Stop("South Huntington Ave and Huntington Ave, Boston, MA", 42.331684, -71.111931, 2, "place-rvrwy", "Riverway"),
  "place-sbmnl": Stop("100 Boylston St, Jamaica Plain, MA", 42.317062, -71.104248, 1, "place-sbmnl", "Stony Brook"),
  "place-sdmnl": Stop("1230 Bennington St, East Boston, MA 02128", 42.390501, -70.997123, 1, "place-sdmnl", "Suffolk Downs"),
  "place-shmnl": Stop("125 Savin Hill Ave, Dorchester, MA 02124", 42.31129, -71.053331, 1, "place-shmnl", "Savin Hill"),
  "place-smary": Stop("Beacon St and Saint Mary's St, Boston, MA", 42.345974, -71.107353, 1, "place-smary", "Saint Mary's Street"),
  "place-smmnl": Stop("Dayton St and Clementine Park, Dorchester, MA 02124", 42.293126, -71.065738, 1, "place-smmnl", "Shawmut"),
  "place-sougr": Stop("None", 42.3396, -71.157661, 2, "place-sougr", "South Street"),
  "place-spmnl": Stop("Leverett Circle and Nashua St, Boston, MA 02114", 42.366664, -71.067666, 1, "place-spmnl", "Science Park/West End"),
  "place-sstat": Stop("700 Atlantic Ave, Boston, MA 02110", 42.352271, -71.055242, 1, "place-sstat", "South Station"),
  "place-state": Stop("200 Washington St, Boston, MA", 42.358978, -71.057598, 1, "place-state", "State"),
  "place-sthld": Stop("Commonwealth Ave and Sutherland Rd, Boston, MA", 42.341614, -71.146202, 2, "place-sthld", "Sutherland Road"),
  "place-stpul": Stop("Beacon St and Saint Paul St, Brookline, MA 02446", 42.343327, -71.116997, 2, "place-stpul", "Saint Paul Street"),
  "place-sull": Stop("Maffa Way and Cambridge St, Charlestown, MA 02129", 42.383975, -71.076994, 1, "place-sull", "Sullivan Square"),
  "place-sumav": Stop("Beacon St and Summit Ave, Brookline, MA", 42.34111, -71.12561, 2, "place-sumav", "Summit Avenue"),
  "place-symcl": Stop("Massachusetts Ave and Huntington Ave, Boston, MA", 42.342687, -71.085056, 2, "place-symcl", "Symphony"),
  "place-tapst": Stop("Beacon St and Tappan St, Brookline, MA", 42.338459, -71.138702, 2, "place-tapst", "Tappan Street"),
  "place-tumnl": Stop("750 Washington St, Boston, MA", 42.349662, -71.063917, 1, "place-tumnl", "Tufts Medical Center"),
  "place-unsqu": Stop("50 Prospect St, Somerville, MA 02143", 42.377359, -71.094761, 1, "place-unsqu", "Union Square"),
  "place-valrd": Stop("291 Valley Rd, Milton, MA 02186", 42.268347, -71.081343, 2, "place-valrd", "Valley Road"),
  "place-waban": Stop("Beacon St and Waban Sq, Newton, MA 02468", 42.325845, -71.230609, 2, "place-waban", "Waban"),
  "place-wascm": Stop("Commonwealth Ave and Washington St, Boston, MA", 42.343864, -71.142853, 1, "place-wascm", "Washington Street"),
  "place-welln": Stop("Revere Beach Pkwy and Rivers Edge Dr, Medford, MA 02155", 42.40237, -71.077082, 1, "place-welln", "Wellington"),
  "place-wimnl": Stop("450 Bennington St, East Boston, MA", 42.37964, -71.022865, 1, "place-wimnl", "Wood Island"),
  "place-wlsta": Stop("90 Woodbine St, Quincy, MA 02171", 42.266514, -71.020337, 1, "place-wlsta", "Wollaston"),
  "place-wondl": Stop("1300 North Shore Rd, Revere, MA 02151", 42.41342, -70.991648, 1, "place-wondl", "Wonderland"),
  "place-woodl": Stop("1940 Washington St, Newton, MA 02466", 42.332902, -71.243362, 1, "place-woodl", "Woodland"),
  "place-wrnst": Stop("Commonwealth Ave and Warren St, Boston, MA", 42.348343, -71.140457, 2, "place-wrnst", "Warren Street"),
  "place-wtcst": Stop("Congress St and World Trade Center Ave, Boston, MA", 42.34863, -71.04246, 1, "place-wtcst", "World Trade Center")
};