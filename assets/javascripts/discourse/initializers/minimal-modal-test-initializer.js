import { apiInitializer } from "discourse/lib/api";
// Removed hbs import as it seemed unnecessary
import MinimalButton from "../components/minimal-button"; // Import the button component

export default apiInitializer((api) => { // Removed version constraint
  console.log("Minimal Modal Test Initializer: Registering value transformer.");

  api.registerValueTransformer("post-menu-buttons", ({ value: dag, context }) => {
    const { post } = context;

    // Simple condition: Add button only to the very first post (post_number 1)
    if (post?.post_number === 1) {
      console.log(`Minimal Modal Test Transformer: ADDING button for Post ID: ${post.id}`);
      dag.add(
        "minimalModalButton", // Unique ID
        MinimalButton,        // Component class to render
        {
          after: "like",      // Position after like button
          args: { post: post } // Pass post object to the component
        }
      );
    }
    return dag;
  });

  console.log("Minimal Modal Test Initializer: Value transformer registered.");
});
