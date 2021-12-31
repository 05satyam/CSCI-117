
#include <iostream>
#include <fstream>
#include <string>
#include <cassert>
#include <map>
#include <bits/stdc++.h>
#include <exception>

#include "ns3/core-module.h"
#include "ns3/attribute.h"
#include "ns3/net-device.h"
#include "ns3/attribute-accessor-helper.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/object-ptr-container.h"
#include "ns3/point-to-point-module.h"
#include "ns3/csma-module.h"
#include "ns3/applications-module.h"
#include "ns3/ipv4-static-routing-helper.h"
#include "ns3/netanim-module.h"
#include "ns3/mobility-model.h"
#include "ns3/flow-monitor-helper.h"
//#include "../examples/astar.h"
//#include "../examples/astar.cc"

using namespace std;

#define DISCONNECTED -1
int num_of_node,num_of_edge,graph[30][30],pathCost[30];
int result[30];
void init_Heuristic();

struct Node{
    int from,to;
    int cost;
};

struct CompareNode{
    bool operator()(Node& n1, Node& n2){
        if(n1.cost > n2.cost)return true;
        return false;
    }
};
map<int,int>Heuristic;
priority_queue<Node, vector<Node>, CompareNode> PQ;
vector<Node>path;
int* AStarSearch(){
	/*
	int source,int destination
	cout << "Enter Node: " << endl;
    cin >> num_of_node;
    cout << "Enter Edge: " << endl;
    cin >> num_of_edge;
    */
    num_of_node = 6;
    num_of_edge = 18;
    int source = 1;
    int destination = 6;
    for(int i=1; i<=num_of_node; i++)
  for(int j=1; j<=num_of_edge; j++)
   graph[i][j] = DISCONNECTED;
	graph[1][2] = graph[2][1] = 7;	graph[3][5] = graph[5][3] = 11;
	graph[1][3] = graph[3][1] = 2;	graph[4][5] = graph[5][4] = 10;
	graph[2][3] = graph[3][2] = 1;	graph[4][6] = graph[6][4] = 7;
	graph[2][4] = graph[4][2] = 5;	graph[5][6] = graph[6][5] = 4;
	graph[2][5] = graph[5][2] = 3;	//graph[4][2] = graph[2][4] = 4;

    init_Heuristic();
    for(int i = 1; i <= num_of_node; i++){
        if(graph[source][i] != DISCONNECTED){
            Node n;
            n.from = source;
            n.to = i;
            n.cost = graph[source][i] + Heuristic[i];
            pathCost[i] = graph[source][i];
            PQ.push(n);
        }
    }
    while(!PQ.empty()){
        Node tmp = PQ.top();
        path.push_back(tmp);
        if(tmp.to == destination)break;
        PQ.pop();
        for(int i = 1; i <= num_of_node; i++){
            if(graph[tmp.to][i] != DISCONNECTED){
                Node n;
                n.from = tmp.to;
                n.to = i;
                n.cost = pathCost[tmp.to] + graph[tmp.to][i] + Heuristic[i];
                pathCost[i] = pathCost[tmp.to] + graph[tmp.to][i];
                PQ.push(n);
            }
        }
    }
    int n = path.size();
    //int m = n + 1;
    //extern int result[10];
    for (int i = 0; i < n; i++)
    {
    	 result[i] = path.at(i).from;
    	 std::cout<<"A star result - "<< result[i] << "\t";
    }
    result[n] = path.at(n-1).to;
    std::cout<< result[n] << std::endl;
    //returner.lonodes = result;
    //returner.num = m;
    return result;
}


void init_Heuristic(){

    ///straight line distance ///

    Heuristic[1] = 80;       Heuristic[13] = 0;
    Heuristic[2] = 74;       Heuristic[14] = 77;
    Heuristic[3] = 53;       Heuristic[15] = 80;
    Heuristic[4] = 66;       Heuristic[16] = 15;
    Heuristic[5] = 29;       Heuristic[17] = 16;
    Heuristic[6] = 19;       Heuristic[18] = 19;
    Heuristic[7] = 17;       Heuristic[19] = 22;
    Heuristic[8] = 44;       Heuristic[20] = 23;
    Heuristic[9] = 41;
    Heuristic[10] = 42;
    Heuristic[11] = 16;
    Heuristic[12] = 10;
}

using namespace ns3;
NS_LOG_COMPONENT_DEFINE ("FANETRouting");

int main (int argc, char *argv[])
{
  CommandLine cmd;
  cmd.Parse (argc, argv);
/*
  int nodesNum = 4;
  int graph[][nodesNum] = {{0, 1,2,3},
    			    {1, 0,2,4},
    			    {2, 2,0,0},
    			    {3,4,0,0}};
  int names[] = {0, 1, 2, 3};
  int Start, End;
  std::cout<< "Enter start node: ";
  std::cin >> Start;
  std::cout<< std::endl<< "Enter Destination node: ";
  std::cin>> End;
  std::cout<< std::endl;

  vector<Node> res = AStarSearch(source,destination);
  int n =res.size();
  int result[n];

  for (int i = 0; i < n; i++)
  {
  	result[i] = res[i];
  	std::cout << result[i] << "\t";
  	finalRoute.Add (nodes.Get(result[i]));
  }
*/


  /*
    int source,destination;
    std::cout << "Enter source: " << std::endl;
    std::cin >> source;
    std::cout << "Enter destination: " << std::endl;
    std::cin >> destination;
    */
    //vector<Node> res = AStarSearch(source,destination);
    //for(int i = 0; i < path.size(); i++)
    //    cout << path.at(i).from << " -> " << path.at(i).to << " = " << path.at(i).cost << endl;
    //int source = 4, destination = 3;
    /*int n = path.size();
    int m = n + 1;
    int result [m];
    for (int i = 0; i < n; i++)
    {
    	 result[i] = funcresult.at(i).from;
    }
    result[n] = funcresult.at(n-1).to;
	*/
    //int m = 1;
    uint32_t num_node = 6;
    NodeContainer nodes;
    nodes.Create (num_node);

    NodeContainer finalRoute;

    int* result = AStarSearch();
    int dstn = 6;
    int i = -1;
    do
    {
    	  i++;
  	  //result[i] = res[i];
  	  std::cout << result[i] << "\t";
  	  finalRoute.Add (nodes.Get(result[i]-1));
  	  //m ++;
    }
    while (result[i] != dstn);




/*
  std::list<int> result[] = a_Star(Start, End, names, graph, heuristic);
  std::cout<< "Shortest route:  ";
  for (uint32_t i = 0; i < 5; ++i)
    {
    	  int itr = result[i]
    	  std::cout << itr << "\t";
    	  finalRoute.Add (nodes.Get(itr));
    }
  std::cout << std::endl;
*/
  //Node declaration.
  //for (int i = 0; i < nodesNum; i++)
  //{
  //	std::map<int, Node> mappedNodes = {names[i], nodes[i]};
  //}
  uint32_t num = finalRoute.GetN();
  for (uint32_t a = 0; a < num; a++)
  {
  	std::cout<< finalRoute.Get(a) << std::endl;
  }
  /*int nodeLis[num];
  int j = 0;
  NodeContainer::Iterator i;
      for (i = nodes.Begin (); i != nodes.End (); ++i, ++j)
        {
         	std::cout<< j <<"=" << (*i) << "\t";  // some Node method
        }
  */

  PointToPointHelper pointTopoint;
  pointTopoint.SetDeviceAttribute ("DataRate", StringValue ("5Mbps"));
  pointTopoint.SetChannelAttribute ("Delay", StringValue ("2ms"));

  NetDeviceContainer devices;
  /*
  devices = pointTopoint.Install (finalRoute);

  NodeContainer devStart = NodeContainer (finalRoute.Get(0), finalRoute.Get(1));
  NodeContainer devEnd = NodeContainer (finalRoute.Get(num-2), finalRoute.Get(num-1));

  NetDeviceContainer deviceStart = p2p.Install (devStart);
  NetDeviceContainer deviceEnd = p2p.Install (devEnd);;
  */
  //std::cout<<num;

  NodeContainer AtoB;
  std::cout<< "Size of nodes = " << nodes.GetN()<< std::endl;
  std::cout<< "Size of path nodes = " << finalRoute.GetN()<< std::endl;
  try{
  for (uint32_t j = 0; j < (num-2); j++) // num = 4 0,1 - 1,2 - 2,3
  {
  	std::cout<< "A - "<< result[j]<< "\tB - "<< result[j+1]<< std::endl;
  	std::cout<< nodes.Get(result[j]-1)<< " -- ";
  	AtoB = NodeContainer (nodes.Get(result[j]-1), nodes.Get(result[j+1]-1));
  	std::cout<< nodes.Get(result[j+1]-1)<< std::endl;
  	std::cout<< "- "<< AtoB.Get(j)<< std::endl;
  	//NetDeviceContainer dAB = pointTopoint.Install (AtoB);
  	//int k = j+1;
  	devices.Add (pointTopoint.Install (AtoB));
  	std::cout<< devices.Get(j)<< std::endl;

  }
  }
  catch(const std::exception& e)
  {
  	std::cout<< e.what()<< std::endl;
  }
  AtoB = NodeContainer (nodes.Get(result[num-2]-1), nodes.Get(result[num-1]-1));
  devices.Add (pointTopoint.Install (AtoB));

  uint32_t no_dev = devices.GetN()/2;
  std::cout<< no_dev<< std::endl;
  std::cout<< devices.Get(no_dev-1)<< std::endl;

  /*for (uint32_t k = 0; k < no_dev; k++) // num = 4 0,1 - 1,2 - 2,3
  {
  	std::cout<< devices.Get(k)<< std::endl;
  }*/
  InternetStackHelper internet;
  internet.Install (nodes);

  Ipv4AddressHelper address;
  address.SetBase ("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer interfaces = address.Assign (devices);
  Ipv4InterfaceContainer endlink = address.Assign (devices.Get(no_dev-1));

  //Ipv4AddressHelper ipv4;
  //ipv4.SetBase ("10.1.1.0", "255.255.255.0");
  //NetDeviceContainer S = devices.Get(0);
  //Ipv4InterfaceContainer initLink = Ipv4InterfaceContainer interfaces.Get(0);

  //ipv4.SetBase ("10.1.1.20", "255.255.255.0");
  //NetDeviceContainer E = devices.Get(no_dev-1);
  //Ipv4InterfaceContainer endLink = Ipv4InterfaceContainer interfaces.Get(no_dev-1);

  //ObjectPtrContainerValue ipAddrList;
  //uint32_t ipAddrList[num];
  //ptr<Ipv4> ipAddrList[num]
  //for (uint32_t itr = 0; itr < num; ++itr)
  //{
  //	ipAddrList.Copy (finalRoute.Get(itr)->GetObject<Ipv4> ());
  //}
  Ptr<Ipv4> ipv4Start = nodes.Get(result[0]-1)-> GetObject<Ipv4> ();
  Ptr<Ipv4> ipv4End = nodes.Get(result[num-1]-1)-> GetObject<Ipv4> ();

  //Ptr<Ipv4> ipv4Start = interfaces.GetAddress(0);
  //Ptr<Ipv4> ipv4End = interfaces.GetAddress(no_dev-1);

  //Ptr<Node> Start = (finalRoute.Begin());
  //Ptr<Node> End = (finalRoute.End());
  CsmaHelper csma;
  csma.SetChannelAttribute ("DataRate", StringValue ("100Mbps"));
  csma.SetChannelAttribute ("Delay", TimeValue (NanoSeconds (6560)));

  //NetDeviceContainer csmaNodes = NetDeviceContainer (devices.Get(0), devices.Get(no_dev-1));

  NetDeviceContainer csmaDevices;

  for (uint32_t k = 0; k < num; k++)
  {
  	NetDeviceContainer csmaDev = csma.Install (nodes.Get(result[k]-1));
  	csmaDevices.Add (csmaDev);
  }

  int32_t ifIndexStart = ipv4Start -> AddInterface (csmaDevices.Get(0));
  int32_t ifIndexEnd = ipv4End -> AddInterface (csmaDevices.Get(num-1));



  Ipv4InterfaceAddress ifInAddrStart = Ipv4InterfaceAddress (Ipv4Address ("172.16.1.1"), Ipv4Mask ("/32"));
  ipv4Start->AddAddress (ifIndexStart, ifInAddrStart);
  ipv4Start->SetMetric (ifIndexStart, 1);
  ipv4Start->SetUp (ifIndexStart);


  Ipv4InterfaceAddress ifInAddrEnd = Ipv4InterfaceAddress (Ipv4Address ("192.168.1.1"), Ipv4Mask ("/32"));
  ipv4End->AddAddress (ifIndexEnd, ifInAddrEnd);
  ipv4End->SetMetric (ifIndexEnd, 1);
  ipv4End->SetUp (ifIndexEnd);

  Ipv4StaticRoutingHelper ipv4RoutingHelper;
  //Ipv4RoutingHelper ipv4RoutingHelp;
  //uint32_t nodeRouting[];
  int counter = 0;
  //char adr1= "10.1.1.2";
  uint32_t ele = 0;
  for (; ele < num-1; ele++)
  {
  	Ptr<Ipv4> ipv4node = nodes.Get(result[ele]-1)->GetObject<Ipv4> ();
  	std::cout<<"--"<< result[ele]-1<< std::endl;
  	Ptr<Ipv4StaticRouting> RoutingNode = ipv4RoutingHelper.GetStaticRouting (ipv4node);
  	counter++;

    	RoutingNode -> AddHostRouteTo (Ipv4Address ("192.168.1.1"),Ipv4Address ("10.1.2.25"), counter);
  }
  //Ptr<Ipv4> ipv4node = nodes.Get(result[ele-1]-1)->GetObject<Ipv4> ();
  //std::cout<<"--"<< result[ele]-1<< std::endl;
  	//Ptr<Ipv4StaticRouting> RoutingNode = ipv4RoutingHelper.GetStaticRouting (ipv4node);
  	//counter++;

    	//RoutingNode -> AddHostRouteTo (Ipv4Address ("192.168.1.1"),Ipv4Address ("10.1.2.30"), counter);

  uint32_t strn = result[0]-1;
  uint32_t endn = result[num-1]-1;
  std::cout<< "Start - "<< strn<< "\t end - "<< endn<< std::endl;

  NS_LOG_INFO ("Create Applications.");
  uint16_t port = 9;
  OnOffHelper onoff ("ns3::UdpSocketFactory",
                     Address (InetSocketAddress (endlink.GetAddress (0), port)));
  onoff.SetConstantRate (DataRate (6000));
  ApplicationContainer apps = onoff.Install (nodes.Get(strn));
  apps.Start (Seconds (1.0));
  apps.Stop (Seconds (10.0));

  // Create a packet sink to receive these packets
  PacketSinkHelper sink ("ns3::UdpSocketFactory",
                         Address (InetSocketAddress (Ipv4Address::GetAny (), port)));
  apps = sink.Install (nodes.Get(endn));
  apps.Start (Seconds (1.0));
  apps.Stop (Seconds (10.0));

  AsciiTraceHelper ascii;
  pointTopoint.EnableAsciiAll (ascii.CreateFileStream ("FANET-routing-cpy.tr"));
  pointTopoint.EnablePcapAll ("FANET-routing-cpy");
  AnimationInterface anim("FANET-routing-cpy.xml");
/*
  UdpEchoServerHelper echoServer (9);

  ApplicationContainer serverApps = echoServer.Install (nodes.Get(0));
  serverApps.Start (Seconds (1.0));
  serverApps.Stop (Seconds (10.0));

 UdpEchoClientHelper echoClient (interfaces.GetAddress(0), 9);
  echoClient.SetAttribute ("MaxPackets", UintegerValue (1));
  echoClient.SetAttribute ("Interval", TimeValue (Seconds (1.0)));
  echoClient.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer clientApps = echoClient.Install (nodes.Get(1));
  clientApps.Start (Seconds (2.0));
  clientApps.Stop (Seconds (10.0));


  AsciiTraceHelper ascii;
  pointTopoint.EnableAsciiAll (ascii.CreateFileStream ("FANET-routing.tr"));
  pointTopoint.EnablePcapAll ("FANET-routing");
  AnimationInterface anim("FANET-routing.xml");
 */
  bool enableFlowMonitor = false;
  FlowMonitorHelper flowmonHelper;
   if (enableFlowMonitor)
     {
       flowmonHelper.InstallAll ();
     }

   NS_LOG_INFO ("Run Simulation.");
   Simulator::Stop (Seconds (2));
   Simulator::Run ();
   NS_LOG_INFO ("Done.");

   if (enableFlowMonitor)
     {
       flowmonHelper.SerializeToXmlFile ("simple-global-routing.flowmon", false, false);
     }
  //Simulator::Run ();
  Simulator::Destroy ();

  //Simulator::Run ();
  //Simulator::Destroy ();

  return 0;
}
copyofworkingcode.cc
Displaying copyofworkingcode.cc.
