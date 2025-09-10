from diagrams import Diagram, Cluster, Edge
from diagrams.onprem.database import Postgresql
from diagrams.onprem.workflow import Airflow
from diagrams.onprem.container import Docker
from diagrams.onprem.analytics import Powerbi, Spark
from diagrams.generic.storage import Storage
import os


os.environ["PATH"] += os.pathsep + 'C:/Program Files/Graphviz/bin/'


with Diagram("Data Pipeline V0", show=False):

    flow = Spark("Spark jobs prototyped in\nJupyter Notebooks")

    with Cluster("Transaction capture from dataset"):
        source = Storage("dataset")
        oltp = Postgresql("OLTP")
        source >> Edge(label="Python Scripts") >> oltp

    with Cluster("Staging", direction="TB"):
        olap = Postgresql("OLAP")
        ds_files = Storage("flat files for ML")

    with Cluster("Presentation", direction="TB"):
        bi = Powerbi("Dashboards")
        notebooks = Spark("Jupyter Notebooks\nfor Data Science")

    oltp >> flow
    flow >> olap
    flow >> ds_files
    olap >> bi
    ds_files >> notebooks

