#!/usr/bin/env bash

/usr/local/spark/bin/spark-submit \
  --class "CallNetwork" \
  --master local[4] \
  target/scala-2.10/mint-project_2.10-1.0.jar
