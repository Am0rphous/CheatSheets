#     Graphs and Charts

To summarize all resources and display them in a pie chart, do the following: Go to portal.azure.com -> Resource Manager -> Tools -> Resource graph explorer and run code below. On "Charts" choose between pie or bar chart. 
```shell
Resources
| summarize resourceCount=count() by location
| order by resourceCount desc
```

In `Resource visualizer` click "Choose resources" and mark VMs etc. Click "Apply" and an image will be generated.
