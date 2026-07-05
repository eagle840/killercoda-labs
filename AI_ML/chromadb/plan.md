# Lab Update Plan: Chromadb Vector Database

This plan outlines the steps to improve the Chromadb lab based on the recent review.

- [x] 1. **Refine `step1.md`**: Remove the installation of `pip-tools` as it is not used in the lab, and clean up the dependency installation sequence.
- [x] 2. **Optimize Setup (`step3.md` context)**: Streamline the installation of `sentence-transformers` by either moving it to the initial setup (`step1`) or running it as a background process to improve the immediate user experience.
- [x] 3. **Cleanup `step3.md`**: Remove redundant text warnings regarding installation time.
- [x] 4. **Develop `step4.md`**: Implement a new final exercise that demonstrates how to generate embeddings for documents and persist them directly into a Chroma collection.
- [ ] 5. **Validation**: Test the complete lab flow to ensure all instructions are accurate, links are functional, and the narrative remains coherent.
