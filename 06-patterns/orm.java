// ORM: Wrong!
Post post = new Post();
post.setDate(new Date());
post.setTitle("How to cook an omelette");
session.save(post);

// Objects: RIGHT!
Post post = new Post();
post.setDate(new Date());
