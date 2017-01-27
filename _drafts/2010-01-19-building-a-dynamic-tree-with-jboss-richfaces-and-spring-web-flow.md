---
layout: post

title: Building a Dynamic Tree with JBoss RichFaces and Spring Web Flow
author: john_turner
featured: false

categories:
- Rich Faces
- Spring Web Flow
---

Recently I was involved in a project that required a user interface that would facilitate the manipulation of a hierarchical data structure.  I was already using [JBoss RichFaces](http://www.jboss.org/richfaces) so it made perfect sense to utilise the tree and associated components (i.e. recursiveTreeNodesAdaptor and treeNode).  The project was also utilising the [Spring Framework](http://www.springsource.org/about and [Spring web Flow](http://www.springsource.org/webflow) and these were also incorporated into the eventual solution.

To start with, as any good developer does, I searched for existing solutions to the problem and while I found some useful information I did not find exactly what I was looking for.  With this in mind, when I eventually finished the development of the user interface I decided I would share my implementation and hopefully you will find what follows useful.

To allow you to follow along, I have made the source (maven project) available as a <a href="http://thoughtforge.net/wp-content/uploads/2010/01/dynamic-tree-source1.zip">download</a>.  This way, I do not have to worry about explaining everything in minute detail.

For a preview, you can always build the source, deploy to a server and navigate to *http://[server]:[port]/dynamic-tree/spring/flow-main* replacing the [server] and [port] with appropriate values.

<!-- more -->

**The Data Structure**

For the purpose of demonstrating my implementation, I am going to use a simple organisational hierarchy (as discussed in Martin Fowlers book 'Analysis Patterns') as illustrated below:

[caption id="attachment_1381" align="aligncenter" width="239"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure1.png"><img class="size-full wp-image-1381" style="border: 2px solid black; margin: 3px 5px;" title="Data Structure" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure1.png" width="239" height="157" /></a> Figure 1: Data Structure[/caption]</p>

This is a very basic hierarchical data structure but it suffices for my purpose.  The implementation of this class is also very basic and requires little explanation.  To keep things simple, I have not considered the persistence mechanism that was employed.

{% gist d98c87f063da4c70f6177c7a6914d47b %}

Strictly speaking, a Set would have been a more appropriate data structure for the Organisation's children but I encountered strange behaviour by the tree component if Set was used as opposed to List.

**Displaying the Hierarchical Data**

As already mentioned, I used Spring Web Flow to manage the UI conversations and binding with the entity model.  The first step in the flow creates the root Organisation and sets a default name (Joe Bloggs Inc).  The second step is a view step that renders the hierarchical data using the tree component.

{% gist 26a1186db78168ce01731a31ffaeaa92 %}

The reason I have used a nested recursiveTreeNodesAdaptor component is that later in the process, I will be associating a different contextMenu component with the root node than other nodes.

Upon executing the flow the following is rendered.

[caption id="attachment_1383" align="aligncenter" width="520"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure2.png"><img class=" wp-image-1383   " style="border: 2px solid black; margin: 3px 5px;" title="Rendered View" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure2.png" width="520" height="76" /></a> Figure 2: Rendered View[/caption]</p>
</div>

**Creating the Node Selection Listener**

In order to manipulate the tree structure, we will need to be able to determine the currently selected node.  This is achieved by creating a class to listen for the node selection event and configuring this class to receive the event.

The code for the class is straight forward and the listing is as follows:

{% gist c036738b9cba4bc21f3aad51358becb5 %}}

The method getSelectedNodeData will return the Organisation associated with the selected node.

To configure the class to receive the node selection event (via ajax) the tree component attributes need to be amended as follows:

{% gist 268a55a8b60af633a312af9580e3474e %}

**Adding Support for Creating Child Nodes**

Now that we are being notified of the node selection event we will be able to add child nodes to the tree component. This will achieved by adding 2 context menu components (one for the root node and one for all others) and a modal dialog.

{% gist eedc1cdf46b99f60e4caca9bdce089c1 %}}

[caption id="attachment_1388" align="aligncenter" width="580"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure3.png"><img class=" wp-image-1388 " style="border: 2px solid black; margin: 3px 4px;" title="Figure 3" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure3.png" width="580" height="91" /></a> Figure 3: Context Menu[/caption]</p>

As you can see, when the user right clicks on a tree node, the appropriate context menu will be displayed. If the user then clicks on 'Add Child' the addChild flow transition is invoked (via ajax) which creates a child Organisation object. On return from this ajax call the dynamicTreePanel and addChildModalPanel will be re-rendered before displaying the modal panel.

[caption id="attachment_1389" align="aligncenter" width="579"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure4.png"><img class=" wp-image-1389 " style="border: 2px solid black; margin: 3px 5px;" title="Figure 4" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure4.png" width="579" height="299" /></a> Figure 4: Modal Panel[/caption]</p>

When the user clicks on the Ok button, the modal dialog is hidden and the addChildModalPanelConfirm flow transition is invoked. This transition adds the child Organisation to its parent and again on return from this ajax call the dynamicTreePanel and addChildModalPanel will be re-rendered.

When the user clicks on the Cancel button, the modal dialog is hidden and the addChildModalPanelCancel flow transition is invoked. On return from this ajax call the dynamicTreePanel and addChildModalPanel will be re-rendered.

[caption id="attachment_1390" align="aligncenter" width="578"]<a href="http://thoughtforge.net/wp-content/uploads/2010/01/figure5.png"><img class=" wp-image-1390 " style="border: 2px solid black; margin: 3px 5px;" title="Figure 5" alt="" src="http://thoughtforge.net/wp-content/uploads/2010/01/figure5.png" width="578" height="141" /></a> Figure 5: Tree with Child Nodes[/caption]

I'm sure the wide awake among you have also noticed the addChildModalPanelRendered property.  This property is used to make sure the components that refer to a child Organisation are not rendered if no child organisation exists in the current conversation (i.e. when we are not actually adding a child organisation).

**Adding Support for Editing Node Data**

Now that we are able to add a child node, it is relatively straight forward to add support for editing a node. To achieve this, we will have to add 2 menu items to the already existing context menus and add another modal dialog.

{% gist addf54b790f61961d5713fd7240bec0d %}

As you can see, the context menu's operate in the same way as before as does the flow transitions and modal dialogs. The main difference here is in the flow transition because rather that create a new child Organisation we are editing an existing one.

It is also worth pointing out the use of the ajaxSingle="true" attribute on the Cancel commandButton component. The reason this is used is so that the model is not updated during the ajax request.

**Adding Support for Removing Child Nodes**

Similarly, it is relatively straight forward to add support for removing a child node. To achieve this, we will have to add 2 menu items to the already existing context menus and a transition to the flow step.

**What's Outstanding?**

I did notice during this process is that there are some strange happenings that need to be investigated further.

- When I use a Set as opposed to a List for the child variable in Organisation.java the tree does not bahave as expected.
- When I try to remove the last child node from the root node the tree does not behave as expected

I realise there is some duplication in the above that should be removed but I do hope you have found this useful and look forward to your comments.
